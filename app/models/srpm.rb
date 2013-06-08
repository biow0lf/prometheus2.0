class Srpm < ActiveRecord::Base
  include Redis::Objects

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

  set :acls
  value :leader

  after_save :increment_counter
  after_destroy :decrement_counter

  def to_param
    name
  end

  def maintainers
    acls.reject { |acl| acl[0] == '@' }
  end

  def teams
    acls.reject { |acl| acl[0] != '@' }
  end

  def leader_is_team?
    if leader.value
      return true if leader.value[0] == '@'
      false
    end
  end

  def self.import(branch, file)
    srpm = Srpm.new
    rpm = Rpm.new(file)
    [:name, :version, :release, :epoch, :filename, :summary, :license, :url,
     :description, :vendor, :distribution, :size, :md5].each do |field|
      srpm.send("#{field}=", rpm.send(field))
    end

    group_name = rpm.group
    Group.import(branch, group_name)
    group = Group.in_branch(branch, group_name)

    Maintainer.import(rpm.packager)

    srpm.group_id = group.id
    srpm.groupname = group_name
    # TODO: move this to Rpm class and test this
    # hack for very long summary in openmoko_dfu-util src.rpm
    srpm.summary = 'Broken' if srpm.name == 'openmoko_dfu-util'
    srpm.buildtime = Time.at(rpm.buildtime.to_i)
    srpm.branch_id = branch.id
    srpm.changelogtime = Time.at(rpm.changelogtime.to_i)

    changelogname = rpm.changelogname
    srpm.changelogname = changelogname

    srpm.changelogtext = rpm.changelogtext

    email = srpm.changelogname.chop.split('<')[1].split('>')[0] rescue nil

    if email
      email.downcase!
      email = Maintainer.new.fix_maintainer_email(email)
      Maintainer.import_from_changelogname(changelogname)
      maintainer = Maintainer.where(email: email).first
      srpm.builder_id = maintainer.id
    end

    if srpm.save
      $redis.set("#{branch.name}:#{srpm.filename}", 1)
      Changelog.import(branch, file, srpm)
      Specfile.import(branch, file, srpm)
      Patch.import(branch, file, srpm)
      Source.import(branch, file, srpm)
    else
      puts "#{Time.now.to_s}: failed to update '#{srpm.filename}'"
    end
  end

  def self.import_all(branch, path)
    Dir.glob(path).each do |file|
      unless $redis.exists("#{branch.name}:#{File.basename(file)}")
        next unless File.exist?(file)
        next unless Rpm.check_md5(file)
        puts "#{Time.now.to_s}: import '#{File.basename(file)}'"
        Srpm.import(branch, file)
      end
    end
  end

  def self.remove_old(branch, path)
    branch.srpms.each do |srpm|
      unless File.exists?("#{path}#{srpm.filename}")
        srpm.packages.each do |package|
          puts "#{Time.now.to_s}: delete '#{package.filename}' from redis cache"
          $redis.del("#{branch.name}:#{package.filename}")
        end
        puts "#{Time.now.to_s}: delete '#{srpm.filename}' from redis cache"
        $redis.del("#{branch.name}:#{srpm.filename}")
        srpm.destroy
      end
    end
  end

  def self.contributors(branch, srpm)
    logins = []
    branch.srpms.where(name: srpm.name).first.changelogs.each do |changelog|
      name = changelog.changelogname.split('<')[0].chomp
      name.strip!
      email = changelog.changelogname.chop.split('<')[1]
      next if email.nil?
      email.downcase!
      email = Maintainer.new.fix_maintainer_email(email)
      login = email.split('@')[0]
      logins << login
    end
    Maintainer.where(login: logins.sort.uniq).order(:name)
  end

  private

  def increment_counter
    branch.counter.increment
  end

  def decrement_counter
    branch.counter.decrement
  end
end
