require 'rpmfile'

class Package < ActiveRecord::Base
  belongs_to :branch
  belongs_to :srpm
  belongs_to :group

  validates :srpm, presence: true
  validates :branch, presence: true
  validates :group, presence: true
  validates :groupname, presence: true
  validates :md5, presence: true

  has_many :requires
  has_many :provides
  has_many :obsoletes
  has_many :conflicts

  after_save :set_srpms_delta_flag

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
      package.branch_id = branch.id
      srpm = branch.srpms.where(filename: sourcerpm).first
      package.srpm_id = srpm.id
      if package.save
        Redis.current.set("#{branch.name}:#{package.filename}", 1)
        # #puts "#{Time.now}: updated '#{package.filename}'"
        # Provide.import_provides(rpm, package)
        # Require.import_requires(rpm, package)
        # Conflict.import_conflicts(rpm, package)
        # Obsolete.import_obsoletes(rpm, package)
      else
        puts "#{Time.now}: failed to import '#{package.filename}'"
      end
    else
      puts "#{Time.now}: srpm '#{sourcerpm}' not found in db"
    end
  end

  def self.import_all(branch, pathes)
    pathes.each do |path|
      Dir.glob(path).each do |file|
        unless Redis.current.exists("#{branch.name}:#{file.split('/')[-1]}")
          next unless File.exist?(file)
          next unless Rpm.check_md5(file)
          puts "#{Time.now}: import '#{file.split('/')[-1]}'"
          rpm = RPMFile::Binary.new(file)
          Package.import(branch, rpm)
        end
      end
    end
  end

  private

  def set_srpms_delta_flag
    srpm.delta = true
    srpm.save
  end
end
