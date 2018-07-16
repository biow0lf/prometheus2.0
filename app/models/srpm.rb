# frozen_string_literal: true

require 'rpmfile'

class Srpm < ApplicationRecord
  # include Redis::Objects
  include PgSearch

  belongs_to :branch

  belongs_to :group

  has_many :packages, dependent: :destroy

  has_many :changelogs, dependent: :destroy

  has_one :specfile, dependent: :destroy

  has_many :patches, dependent: :destroy

  has_many :sources, dependent: :destroy

  has_many :repocops, -> { order(name: :asc) },
           primary_key: 'name',
           foreign_key: 'srcname',
           dependent: :destroy

  has_one :repocop_patch,
          primary_key: 'name',
          foreign_key: 'name',
          dependent: :destroy

  has_one :builder,
          class_name: 'Maintainer',
          primary_key: 'builder_id',
          foreign_key: 'id'

  has_many :gears, -> { order(lastchange: :desc) },
           primary_key: 'name',
           foreign_key: 'repo' # dependent: :destroy

  scope :by_branch_name, ->(name) { joins(:branch).where(branches: { name: name }) }

  validates :groupname, presence: true

  validates :md5, presence: true
  validates_presence_of :buildtime

  # delegate :name, to: :branch, prefix: true

  # set :acls

  # value :leader

  after_create :add_filename_to_cache

  after_create :increment_branch_counter

  after_destroy :decrement_branch_counter

  after_destroy :remove_filename_from_cache

  after_destroy :remove_acls_from_cache

  after_destroy :remove_leader_from_cache

  pg_search_scope :query,
                  against: [:name, :summary, :description, :filename, :url],
                  using: { tsearch: { prefix: true } }

  multisearchable against: [:name, :summary, :description, :filename, :url]

  def to_param
    name
  end

  def acls
    return unless Redis.current.exists("#{ branch.name }:#{ name }:acls")
    Maintainer.where(login: Redis.current.smembers("#{ branch.name }:#{ name }:acls")).order(:name).select('login').map(&:login).join(',')
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
      Changelog.import_from(file, srpm)
      Specfile.import(file, srpm)
      Patch.import(file, srpm)
      Source.import(file, srpm)
    else
      puts "#{ Time.now }: failed to update '#{ srpm.filename }'"
    end
  end

  def self.import_all(branch, path)
    Dir.glob(path).sort.each do |file|
      unless Redis.current.exists("#{ branch.name }:#{ File.basename(file) }")
        next unless File.exist?(file)
        next unless RPMCheckMD5.check_md5(file)
        puts "#{ Time.now }: import '#{ File.basename(file) }'"
        Srpm.import(branch, RPMFile::Source.new(file), file)
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

  def add_filename_to_cache
    Redis.current.set("#{ branch.name }:#{ filename }", 1)
  end

  def increment_branch_counter
    branch.counter.increment
  end

  def decrement_branch_counter
    branch.counter.decrement
  end

  def remove_filename_from_cache
    Redis.current.del("#{ branch.name }:#{ filename }")
  end

  def remove_acls_from_cache
    Redis.current.del("#{ branch.name }:#{ name }:acls")
  end

  def remove_leader_from_cache
    Redis.current.del("#{ branch.name }:#{ name }:leader")
  end
end
