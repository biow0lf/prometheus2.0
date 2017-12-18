# frozen_string_literal: true

require 'rpmfile'

class Package < ApplicationRecord
  belongs_to :srpm

  belongs_to :group

  has_many :requires, dependent: :destroy

  has_many :provides, dependent: :destroy

  has_many :obsoletes, dependent: :destroy

  has_many :conflicts, dependent: :destroy

  validates :groupname, presence: true

  validates :md5, presence: true

  after_save :set_srpm_delta_flag

  after_create :add_filename_to_cache

  after_destroy :remove_filename_from_cache

  def self.import(branch, rpm)
    sourcerpm = rpm.sourcerpm
    if branch.srpms.where(filename: sourcerpm).count == 1
      package = Package.new
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
      package.summary = 'Broken' if package.name == 'openmoko_dfu-util'
      package.license = rpm.license
      package.url = rpm.url
      package.description = rpm.description
      package.buildtime = rpm.buildtime
      package.size = rpm.size
      package.md5 = rpm.md5
      srpm = branch.srpms.where(filename: sourcerpm).first
      package.srpm_id = srpm.id
      if package.save
        # Provide.import_provides(rpm, package)
        # Require.import_requires(rpm, package)
        # Conflict.import_conflicts(rpm, package)
        # Obsolete.import_obsoletes(rpm, package)
      else
        puts "#{ Time.now }: failed to import '#{ package.filename }'"
      end
    else
      puts "#{ Time.now }: srpm '#{ sourcerpm }' not found in db"
    end
  end

  def self.import_all(branch, pathes)
    pathes.each do |path|
      Dir.glob(path).sort.each do |file|
        unless Redis.current.exists("#{ branch.name }:#{ file.split('/')[-1] }")
          next unless File.exist?(file)
          next unless RPMCheckMD5.check_md5(file)
          puts "#{ Time.now }: import '#{ file.split('/')[-1] }'"
          rpm = RPMFile::Binary.new(file)
          Package.import(branch, rpm)
        end
      end
    end
  end

  private

  def set_srpm_delta_flag
    srpm.update_attribute(:delta, true)
  end

  def add_filename_to_cache
    Redis.current.set("#{ srpm.branch.name }:#{ filename }", 1)
  end

  def remove_filename_from_cache
    Redis.current.del("#{ srpm.branch.name }:#{ filename }")
  end
end
