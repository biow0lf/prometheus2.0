# frozen_string_literal: true

require 'rpmfile'

class Srpm < ApplicationRecord
  class AlreadyExistError < StandardError; end
  class AttachedNewBranchError < StandardError; end

  belongs_to :group
  belongs_to :builder, class_name: 'Maintainer', inverse_of: :srpms, counter_cache: :srpms_count

  has_one :specfile, dependent: :destroy
  has_one :repocop_patch,
          primary_key: 'name',
          foreign_key: 'name',
          dependent: :destroy

  has_many :packages, dependent: :destroy
  has_many :named_srpms, dependent: :destroy
  has_many :branches, through: :named_srpms
  has_many :branch_paths, through: :named_srpms
  has_many :changelogs, dependent: :destroy
  has_many :patches, dependent: :destroy
  has_many :sources, dependent: :destroy
  has_many :repocops, -> { order(name: :asc) }, primary_key: 'name',
                                                foreign_key: 'srcname',
                                                dependent: :destroy
  has_many :gears, -> { order(lastchange: :desc) }, primary_key: 'name',
                                                    foreign_key: 'repo'

  scope :q, ->(text) { text.blank? && all || joins(:packages).merge(Package.query(text)).or(self.query(text)) }
  scope :by_branch_name, ->(name) { joins(:branches).where(named_srpms: { branches: { name: name }}) }
  scope :ordered, -> { order('srpms.buildtime DESC') }
  scope :by_arch, ->(arch) { arch.blank? && all || joins(:packages).where(packages: { arch: arch }) }
  scope :by_evr, ->(evr) do
     if evr.blank?
        all
     else
        evrs = evr.split(/[:\-]/)

        if evrs.size == 2
           where(version: evrs[0], release: evrs[1])
        else
           where(epoch: evrs[0], version: evrs[1], release: evrs[2])
        end
     end
  end

  scope :query, ->(text) do
     subquery = "
        SELECT id FROM (SELECT DISTINCT id, tsv, ts_rank_cd(tsv, plainto_tsquery('#{text}'))
        FROM srpms, plainto_tsquery('#{text}') AS q
        WHERE (tsv @@ q)
        ORDER BY ts_rank_cd(tsv, plainto_tsquery('#{text}')) DESC) as t1"
     where("srpms.id IN (#{subquery})")
  end

  scope :top_rebuilds_after, ->(date) do
     where("buildtime > ?", date)
        .select(:name, 'count(srpms.name) as id')
        .group(:name)
        .having('count(srpms.name) > 5')
        .order('id DESC', :name)
  end

  singleton_class.send(:alias_method, :b, :by_branch_name)
  singleton_class.send(:alias_method, :a, :by_arch)

  # delegate :name, to: :branch, prefix: true

  # set :acls

  # value :leader

  validates_presence_of :buildtime, :md5, :groupname, :builder

  def to_param
    name
  end

  def acls
    return unless Redis.current.exists("#{ branch.name }:#{ name }:acls")
    Maintainer.where(login: Redis.current.smembers("#{ branch.name }:#{ name }:acls")).order(:name).select('login').map(&:login).join(',')
  end

  def self.import branch_path, rpm, file
    srpm = Srpm.find_or_initialize_by(md5: rpm.md5) do |srpm|
      # TODO: add srpm.buildhost
      srpm.name = rpm.name
      srpm.version = rpm.version
      srpm.release = rpm.release
      srpm.epoch = rpm.epoch

      group_name = rpm.group
      Group.import(branch_path.branch, group_name)
      group = Group.in_branch(branch_path.branch, group_name)

      Maintainer.import(rpm.packager)

      srpm.group_id = group.id
      srpm.groupname = group_name
      srpm.summary = rpm.summary
      # TODO: test for this
      srpm.license = rpm.license
      srpm.url = rpm.url
      srpm.description = rpm.description
      srpm.vendor = rpm.vendor
      srpm.distribution = rpm.distribution
      srpm.buildtime = rpm.buildtime
      srpm.size = rpm.size
      srpm.changelogtime = rpm.changelogtime

      changelogname = rpm.changelogname
      srpm.changelogname = changelogname

      srpm.changelogtext = rpm.changelogtext

      email = srpm.changelogname.chop.split('<')[1].split('>')[0] rescue nil

      srpm.builder = Maintainer.import_from_changelogname(changelogname)

      BranchingMaintainer.find_or_create_by!(maintainer: srpm.builder, branch: branch_path.branch)

      srpm.named_srpms << NamedSrpm.new(branch_path: branch_path,
                                        filename: rpm.filename)
    end

    if srpm.new_record?
      srpm.save!

      Changelog.import_from(file, srpm)
      Specfile.import(file, srpm)
      Patch.import(file, srpm)
      Source.import(file, srpm)
    else
      if srpm.branch_paths.include?(branch_path)
        raise AlreadyExistError
      else
        NamedSrpm.create!(branch_path: branch_path,
                          filename: rpm.filename,
                          srpm: srpm)
        raise AttachedNewBranchError
      end
    end
  end

  def self.import_all branch
    time = Time.zone.now
    Rails.logger.info "IMPORT: at #{time} for #{branch.name} in"

    branch.branch_paths.active.source.each do |branch_path|
      Rails.logger.info "IMPORT: Branch path #{branch_path.path}"

      mins = (time - branch_path.imported_at + 59).to_i / 60
      find = "find #{branch_path.path} -mmin -#{mins} -name '#{branch_path.glob}' | sed 's|#{branch_path.path}/*||' | sort"
      Rails.logger.info "IMPORT: search with: #{find}"

      current_list = `#{find}`.split("\n")
      stored_list = branch_path.named_srpms.where(filename: current_list).select(:filename).pluck(:filename)

      nonexist_list = current_list - stored_list
      Rails.logger.info "IMPORT: will be imported #{nonexist_list.size} files"

      nonexist_list.each do |file|
        Rails.logger.info "IMPORT: file #{file}"
        next unless RPMCheckMD5.check_md5(file)

        info = "IMPORT: file '#{ file }' "
        rpm = RPMFile::Source.new(file)
        (method, state) = begin
          Srpm.import(branch_path, rpm, file)
          [ :info, "imported to branch #{branch_path.branch.name}" ]
        rescue AttachedNewBranchError
          [ :info, "added to branch #{branch_path.branch.name}" ]
        rescue AlreadyExistError
          [ :info, "exists in #{branch_path.branch.name}" ]
        rescue => e
          time = time < rpm.buildtime && time || rpm.buildtime
          [ :error, "failed to update, reason: #{e.message}" ]
        end

        Rails.logger.send(method, info + state)
      end

      branch_path.update(imported_at: time, srpms_count: branch_path.named_srpms.count)
    end

    branch.update(srpms_count: branch.srpm_filenames.count)
  end

  def contributors
    logins = []
    changelogs.each do |changelog|
      next unless changelog.email
      logins << changelog.login
    end
    Maintainer.where(login: logins.sort.uniq).order(:name)
  end

  def filename_in branch
    named_srpms.by_branch_path(branch.branch_paths).first&.name
  end

  class ActiveRecord_Relation
    def page value
      @page = (value || 1).to_i
      @total_count = self[0] && self.size || 0

      self.class_eval do
        def total_count
          @total_count
        end

        def total_pages
          (@total_count + 24) / 25
        end

        def current_page
          @page
        end

        def each &block
          range = ((@page - 1) * 25...@page * 25)
          self[range].each(&block)
        end
      end

      self
    end
  end
end
