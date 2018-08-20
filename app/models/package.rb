# frozen_string_literal: true

require 'rpmfile'

class Package < ApplicationRecord
  class AlreadyExistError < StandardError; end
  class SourceIsntFound < StandardError; end

  belongs_to :srpm

  belongs_to :group

  has_many :requires, dependent: :destroy

  has_many :provides, dependent: :destroy

  has_many :obsoletes, dependent: :destroy

  has_many :conflicts, dependent: :destroy

  has_many :branches, through: :srpm

  scope :query, ->(text) do
     subquery = "
        SELECT id FROM (SELECT DISTINCT id, tsv, ts_rank_cd(tsv, plainto_tsquery('#{text}'))
        FROM packages, plainto_tsquery('#{text}') AS q
        WHERE (tsv @@ q)
        ORDER BY ts_rank_cd(tsv, plainto_tsquery('#{text}')) DESC) as t1"
     where("packages.id IN (#{subquery})")
  end

  validates :groupname, presence: true

  validates :md5, presence: true

  after_create :add_filename_to_cache

  after_destroy :remove_filename_from_cache

  def self.import branch_path, rpm
    sourcerpm = rpm.sourcerpm
    srpm_id = NamedSrpm.where(filename: sourcerpm, branch_path_id: branch_path.branch.branch_paths.source.select(:id)).first&.srpm_id

    if srpm_id
      package = Package.find_or_initialize_by(md5: rpm.md5) do |package|
        package.filename = rpm.filename
        package.sourcepackage = sourcerpm
        package.name = rpm.name
        package.version = rpm.version
        package.release = rpm.release
        package.epoch = rpm.epoch
        package.arch = rpm.arch

        group_name = rpm.group
        Group.import(branch_path.branch, group_name)
        group = Group.in_branch(branch_path.branch, group_name)

        package.group_id = group.id
        package.groupname = group_name
        package.summary = rpm.summary
        package.license = rpm.license
        package.url = rpm.url
        package.description = rpm.description
        package.buildtime = rpm.buildtime
        package.size = rpm.size
        package.srpm_id = srpm_id
      end

      if package.new_record?
        package.save!

        # Provide.import_provides(rpm, package)
        # Require.import_requires(rpm, package)
        # Conflict.import_conflicts(rpm, package)
        # Obsolete.import_obsoletes(rpm, package)
      else
        raise AlreadyExistError
      end
    else
      raise SourceIsntFound.new(sourcerpm)
    end
  end

  def self.import_all branch
    time = Time.zone.now
    Rails.logger.info "IMPORT: at #{time} in"
    branch.branch_paths.package.each do |branch_path|
      Rails.logger.info "IMPORT: Branch path #{branch_path.path}"
      next if !branch_path.active?

      mins = (time - branch_path.imported_at + 59).to_i / 60
      find = "find #{branch_path.path} -mmin -#{mins} -name '#{branch_path.glob}' | sort"
      Rails.logger.info "IMPORT: search with: #{find}"
      `#{find}`.split("\n").each do |file|
        Rails.logger.info "IMPORT: file #{file}"
        next unless File.exist?(file)
        next unless RPMCheckMD5.check_md5(file)

        info = "IMPORT: file '#{ file }' "
        rpm = RPMFile::Binary.new(file)
        (method, state) = begin
          Package.import(branch_path, rpm)
          [ :info, "imported to branch #{branch_path.branch.name}" ]
        rescue AlreadyExistError
          [ :info, "exists in #{branch_path.branch.name}" ]
        rescue SourceIsntFound => e
          [ :error, "#{e.message} source isn't found for #{branch_path.branch.name}" ]
        rescue => e
          time = time < rpm.buildtime && time || rpm.buildtime
          [ :error, "failed to update, reason: #{e.message}" ]
        end

        Rails.logger.send(method, info + state)
      end

      branch_path.update(imported_at: time)
    end
  end

  private

  def add_filename_to_cache
    srpm.named_srpms.each do |named_srpm|
      Redis.current.set("#{ named_srpm.branch.name }:#{ filename }", 1)
    end
  end

  def remove_filename_from_cache
    srpm.named_srpms.each do |named_srpm|
      Redis.current.del("#{ named_srpm.branch.name }:#{ filename }")
    end
  end
end
