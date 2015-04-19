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

  def self.import_all(branch, path)
    Dir.glob(path).each do |file|
      unless Redis.current.exists("#{branch.name}:#{File.basename(file)}")
        next unless File.exist?(file)
        next unless Rpm.check_md5(file)
        puts "#{Time.now}: import '#{File.basename(file)}'"
        SrpmImport.new(branch, Srpm.new, RPMFile::Source.new(file), file).execute
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
      next unless changelog.email
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
