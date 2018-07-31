# frozen_string_literal: true

require 'rpmfile'

class Package < ApplicationRecord
  include PgSearch

  belongs_to :srpm

  belongs_to :group

  has_many :requires, dependent: :destroy

  has_many :provides, dependent: :destroy

  has_many :obsoletes, dependent: :destroy

  has_many :conflicts, dependent: :destroy

  has_many :branches, through: :srpm

  validates :groupname, presence: true

  validates :md5, presence: true

  after_create :add_filename_to_cache

  after_destroy :remove_filename_from_cache

  pg_search_scope :query,
                  against: %i(name summary description filename sourcepackage),
                  using: { tsearch: { prefix: true } }

  multisearchable against: [:name, :summary, :description, :filename,
                            :sourcepackage]

  def self.import(branch, rpm)
    sourcerpm = rpm.sourcerpm
    srpm_id = NamedSrpm.where(name: sourcerpm, branch_id: branch.id).first&.srpm_id

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
        Group.import(branch, group_name)
        group = Group.in_branch(branch, group_name)

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
        if package.save
          # Provide.import_provides(rpm, package)
          # Require.import_requires(rpm, package)
          # Conflict.import_conflicts(rpm, package)
          # Obsolete.import_obsoletes(rpm, package)
          Rails.logger.info "imported '#{ package.filename }'"
        else
          Rails.logger.error "failed to import '#{ package.filename }'"
        end
      end
    else
      Rails.logger.error "srpm '#{ sourcerpm }' not found in db"
    end
  end

  def self.import_all(branch, pathes)
    pathes.each do |path|
      Dir.glob(path).sort.each do |file|
        unless Redis.current.exists("#{ branch.name }:#{ file.split('/')[-1] }")
          next unless File.exist?(file)
          next unless RPMCheckMD5.check_md5(file)
          rpm = RPMFile::Binary.new(file)
          Package.import(branch, rpm)
        end
      end
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
