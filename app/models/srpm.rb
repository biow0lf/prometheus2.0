require 'rpmfile'

class Srpm < ActiveRecord::Base
  # include Redis::Objects

  belongs_to :branch
  belongs_to :group

  validates :branch, presence: true
  validates :group, presence: true
  validates :groupname, presence: true
  validates :md5, presence: true

  has_many :packages, dependent: :destroy
  has_many :changelogs, dependent: :destroy
  has_one :specfile, dependent: :destroy
  has_many :patches, dependent: :destroy
  has_many :sources, dependent: :destroy

  has_many :repocops, foreign_key: 'srcname', primary_key: 'name'
  has_one :repocop_patch, foreign_key: 'name', primary_key: 'name'

  has_one :builder, class_name: 'Maintainer', foreign_key: 'id',
                    primary_key: 'builder_id'

  # set :acls
  # value :leader

  after_create :increment_branch_counter
  after_destroy :decrement_branch_counter

  def to_param
    name
  end

  def acls
    return unless Redis.current.exists("#{branch.name}:#{name}:acls")
    Maintainer.where(login: Redis.current.smembers("#{branch.name}:#{name}:acls")).order(:name).select('login').map(&:login).join(',')
  end

  def self.import(branch, rpm, file)
    srpm = Srpm.new
    # TODO: add srpm.buildhost
    srpm.name = rpm.name
    srpm.version = rpm.version
    srpm.release = rpm.release
    srpm.epoch = rpm.epoch
    srpm.filename = rpm.filename

    group_name = rpm.group
    Group.import(branch, group_name)
    group = Group.in_branch(branch, group_name)

    Maintainer.import(rpm.packager)

    srpm.group_id = group.id
    srpm.groupname = group_name
    srpm.summary = rpm.summary
    # TODO: test for this
    # hack for very long summary in openmoko_dfu-util src.rpm
    srpm.summary = 'Broken' if srpm.name == 'openmoko_dfu-util'
    srpm.license = rpm.license
    srpm.url = rpm.url
    srpm.description = rpm.description
    srpm.vendor = rpm.vendor
    srpm.distribution = rpm.distribution
    srpm.buildtime = rpm.buildtime
    srpm.size = rpm.size
    srpm.md5 = rpm.md5
    srpm.branch_id = branch.id
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

    if srpm.save
      Redis.current.set("#{branch.name}:#{srpm.filename}", 1)
      Changelog.import(file, srpm)
      Specfile.import(file, srpm)
      Patch.import(file, srpm)
      Source.import(file, srpm)
    else
      puts "#{Time.now}: failed to update '#{srpm.filename}'"
    end
  end

  def self.import_all(branch, path)
    Dir.glob(path).each do |file|
      unless Redis.current.exists("#{branch.name}:#{File.basename(file)}")
        next unless File.exist?(file)
        next unless Rpm.check_md5(file)
        puts "#{Time.now}: import '#{File.basename(file)}'"
        Srpm.import(branch, RPMFile::Source.new(file), file)
      end
    end
  end

  def self.remove_old(branch, path)
    branch.srpms.each do |srpm|
      unless File.exist?("#{path}#{srpm.filename}")
        srpm.packages.each do |package|
          puts "#{Time.now}: delete '#{package.filename}' from redis cache"
          Redis.current.del("#{branch.name}:#{package.filename}")
        end
        puts "#{Time.now}: delete '#{srpm.filename}' from redis cache"
        Redis.current.del("#{branch.name}:#{srpm.filename}")
        puts "#{Time.now}: delete acls for '#{srpm.filename}' from redis cache"
        Redis.current.del("#{branch.name}:#{srpm.name}:acls")
        Redis.current.del("#{branch.name}:#{srpm.name}:leader")
        srpm.destroy
      end
    end
  end

  def contributors
    logins = []
    changelogs.each do |changelog|
      # TODO: add test for this bug.
      next if changelog.email.empty?
      logins << changelog.login
    end
    Maintainer.where(login: logins.sort.uniq).order(:name)
  end

  private

  def increment_branch_counter
    branch.counter.increment
  end

  def decrement_branch_counter
    branch.counter.decrement
  end
end
