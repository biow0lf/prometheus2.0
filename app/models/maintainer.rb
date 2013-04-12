# encoding: utf-8

class Maintainer < ActiveRecord::Base
  include MaintainerHelper

  validates :name, presence: true
  validates :email, presence: true
  validates :login, presence: true, uniqueness: true

  validates :name, immutable: true
  validates :email, immutable: true
  validates :login, immutable: true

  has_many :teams
  has_many :gears
  has_many :ftbfs, class_name: 'Ftbfs'

  attr_accessible :name, :email, :login, :time_zone, :jabber, :info, :location,
                  :website

  def to_param
    login
  end

  def self.login_exists?(login)
    Maintainer.where(login: login.downcase).count > 0
  end

  def self.import(maintainer)
    name = maintainer.split('<')[0].chomp
    name.strip!
    email = maintainer.chop.split('<')[1].split('>')[0]
    email.downcase!
    email = Maintainer.new.fix_maintainer_email(email)
    login = email.split('@')[0]
    domain = email.split('@')[1]
    if domain == 'altlinux.org'
      unless login_exists?(login)
        Maintainer.create(login: login, name: name, email: email)
      end
    elsif domain == 'packages.altlinux.org'
      unless MaintainerTeam.team_exists?(login)
        MaintainerTeam.create(login: login, name: name, email: email)
      end
    else
      raise 'Broken domain in Packager: tag'
    end
  end

  def self.import_from_changelogname(changelogname)
    name = changelogname.split('<')[0].chomp
    name.strip!
    email = changelogname.chop.split('<')[1].split('>')[0]
    email.downcase!
    email = Maintainer.new.fix_maintainer_email(email)
    login = email.split('@')[0]
    domain = email.split('@')[1]
    if domain == 'altlinux.org'
      unless login_exists?(login)
        Maintainer.create(login: login, name: name, email: email)
      end
    elsif domain == 'packages.altlinux.org'
      unless MaintainerTeam.team_exists?(login)
        MaintainerTeam.create(login: login, name: name, email: email)
      end
    else
      raise 'Broken domain in CHANGELOGNAME: tag'
    end
  end

  def self.top15(branch)
    maintainers = []

    Maintainer.select('login, name').each do |maintainer|
      m = [maintainer.login, maintainer.name, $redis.smembers("#{branch.name}:maintainers:#{maintainer.login}").count]
      maintainers << m
    end

    maintainers.sort! { |a, b| b[2] <=> a[2] }
    maintainers[0..14]
  end
end
