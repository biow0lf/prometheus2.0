# frozen_string_literal: true

require 'rpmfile'

class Srpm < ApplicationRecord
  class AlreadyExistError < StandardError; end
  class AttachedNewBranchError < StandardError; end

  # include Redis::Objects
  include PgSearch

  belongs_to :group

  has_one :specfile, dependent: :destroy
  has_one :repocop_patch,
          primary_key: 'name',
          foreign_key: 'name',
          dependent: :destroy
  has_one :builder,
          class_name: 'Maintainer',
          primary_key: 'builder_id',
          foreign_key: 'id'

  has_many :packages, dependent: :destroy
  has_many :named_srpms, dependent: :destroy
  has_many :branches, through: :named_srpms
  has_many :changelogs, dependent: :destroy
  has_many :patches, dependent: :destroy
  has_many :sources, dependent: :destroy
  has_many :repocops, -> { order(name: :asc) }, primary_key: 'name',
                                                foreign_key: 'srcname',
                                                dependent: :destroy
  has_many :gears, -> { order(lastchange: :desc) }, primary_key: 'name',
                                                    foreign_key: 'repo'

  scope :by_branch_name, ->(name) { joins(:branches).where(named_srpms: { branches: { name: name }}) }
  scope :ordered, -> { order('srpms.buildtime DESC') }
  scope :by_arch, ->(arch) { arch.blank? && all || joins(:packages).where(packages: { arch: arch }) }
  scope :q, ->(text) { text.blank? && all || joins(:packages).merge(Package.query(text)).or(self.query(text)) }
  singleton_class.send(:alias_method, :b, :by_branch_name)
  singleton_class.send(:alias_method, :a, :by_arch)

  # delegate :name, to: :branch, prefix: true

  # set :acls

  # value :leader

  after_save    :add_filename_to_cache
  after_create  :increment_branch_counter

  after_destroy :decrement_branch_counter
  after_destroy :remove_filename_from_cache
  after_destroy :remove_acls_from_cache
  after_destroy :remove_leader_from_cache

  pg_search_scope :query,
                  against: %i(name summary description url),
                  using: { tsearch: { prefix: true } }

  multisearchable against: [:name, :summary, :description, :url]

  validates_presence_of :buildtime, :md5, :groupname, :named_srpms

  def to_param
    name
  end

  def acls
    return unless Redis.current.exists("#{ branch.name }:#{ name }:acls")
    Maintainer.where(login: Redis.current.smembers("#{ branch.name }:#{ name }:acls")).order(:name).select('login').map(&:login).join(',')
  end

  def self.import(branch, rpm, file)
    srpm = Srpm.find_or_initialize_by(md5: rpm.md5) do |srpm|
      # TODO: add srpm.buildhost
      srpm.name = rpm.name
      srpm.version = rpm.version
      srpm.release = rpm.release
      srpm.epoch = rpm.epoch

      group_name = rpm.group
      Group.import(branch, group_name)
      group = Group.in_branch(branch, group_name)

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

      if email
        email.downcase!
        email = FixMaintainerEmail.new(email).execute
        Maintainer.import_from_changelogname(changelogname)
        maintainer = Maintainer.where(email: email).first
        srpm.builder_id = maintainer.id
      end

      srpm.named_srpms << NamedSrpm.new(branch_id: branch.id,
                                        name: rpm.filename)
    end

    if srpm.new_record?
      srpm.save!

      Changelog.import_from(file, srpm)
      Specfile.import(file, srpm)
      Patch.import(file, srpm)
      Source.import(file, srpm)
    else
      if srpm.branches.include?(branch)
        raise AlreadyExistError
      else
        srpm.named_srpms << NamedSrpm.new(branch_id: branch.id,
                                          name: rpm.filename)
        raise AttachedNewBranchError
      end
    end
  end

  def self.import_all(branch, path)
    Dir.glob(path).sort.each do |file|
      unless Redis.current.exists("#{ branch.name }:#{ File.basename(file) }")
        next unless File.exist?(file)
        next unless RPMCheckMD5.check_md5(file)

        info = "file '#{ file }' "

        (method, state) = begin
          Srpm.import(branch, RPMFile::Source.new(file), file)
          [ :info, "imported to branch #{branch.name}" ]
        rescue AttachedNewBranchError
          [ :info, "added to branch #{branch.name}" ]
        rescue AlreadyExistError
          [ :info, "exists in #{branch.name}" ]
        rescue => e
          [ :error, "failed to update, reason: #{e.message}" ]
        end

        Rails.logger.send(method, info + state)
      end
    end
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
    named_srpms.by_branch_id(branch).first&.name
  end

  private

  def add_filename_to_cache
    named_srpms.each do |named_srpm|
      Redis.current.set("#{ named_srpm.branch.name }:#{ named_srpm.name }", 1)
    end
  end

  def increment_branch_counter
    named_srpms.each do |named_srpm|
      named_srpm.branch.counter.increment
    end
  end

  def decrement_branch_counter
    named_srpms.each do |named_srpm|
      named_srpm.branch.counter.decrement
    end
  end

  def remove_filename_from_cache
    named_srpms.each do |named_srpm|
      Redis.current.del("#{ named_srpm.branch.name }:#{ named_srpm.name }")
    end
  end

  def remove_acls_from_cache
    named_srpms.each do |named_srpm|
      Redis.current.del("#{ named_srpm.branch.name }:#{ name }:acls")
    end
  end

  def remove_leader_from_cache
    named_srpms.each do |named_srpm|
      Redis.current.del("#{ named_srpm.branch.name }:#{ name }:leader")
    end
  end
end
