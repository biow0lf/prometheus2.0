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

  def self.import(branch, file)
    rpm = Rpm.new(file)
    sourcerpm = rpm.sourcerpm
    if branch.srpms.where(filename: sourcerpm).count == 1
      package = Package.new
      package.filename = file.split('/')[-1]
      package.sourcepackage = sourcerpm
      package.name = rpm.name
      package.version = rpm.version
      package.release = rpm.release
      package.epoch = rpm.epoch
      package.arch = `export LANG=C && rpm -qp --queryformat='%{ARCH}' #{file}`

      group_name = `export LANG=C && rpm -qp --queryformat='%{GROUP}' #{file}`
      Group.import(branch, group_name)
      group = Group.in_branch(branch, group_name)

      package.group_id = group.id
      package.groupname = group_name
      package.summary = `export LANG=C && rpm -qp --queryformat='%{SUMMARY}' #{file}`
      package.summary = 'Broken' if package.name == 'openmoko_dfu-util'
      package.license = `export LANG=C && rpm -qp --queryformat='%{LICENSE}' #{file}`
      package.url = `export LANG=C && rpm -qp --queryformat='%{URL}' #{file}`
      # TODO: make test for this
      package.url = nil if package.url == '(none)'
      package.description = `export LANG=C && rpm -qp --queryformat='%{DESCRIPTION}' #{file}`
      package.buildtime = Time.at(`export LANG=C && rpm -qp --queryformat='%{BUILDTIME}' #{file}`.to_i)
      package.size = File.size(file)
      package.md5 = `/usr/bin/md5sum #{file}`.split[0]
      package.branch_id = branch.id
      srpm = branch.srpms.where(filename: sourcerpm).first
      package.srpm_id = srpm.id
      if package.save
        $redis.set("#{branch.name}:#{package.filename}", 1)
        # #puts "#{Time.now.to_s}: updated '#{package.filename}'"
        # Provide.import_provides(rpm, package)
        # Require.import_requires(rpm, package)
        # Conflict.import_conflicts(rpm, package)
        # Obsolete.import_obsoletes(rpm, package)
      else
        puts "#{Time.now.to_s}: failed to import '#{package.filename}'"
      end
    else
      puts "#{Time.now.to_s}: srpm '#{sourcerpm}' not found in db"
    end
  end

  def self.import_all(branch, pathes)
    pathes.each do |path|
      Dir.glob(path).each do |file|
        unless $redis.exists("#{branch.name}:#{file.split('/')[-1]}")
          next unless File.exist?(file)
          next unless Rpm.check_md5(file)
          puts "#{Time.now.to_s}: import '#{file.split('/')[-1]}'"
          Package.import(branch, file)
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
