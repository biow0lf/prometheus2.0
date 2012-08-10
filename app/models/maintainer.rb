# encoding: utf-8

class Maintainer < ActiveRecord::Base
  include MaintainerHelper

  validates :name, presence: true
  validates :email, presence: true
  validates :login, presence: true, uniqueness: true

  validates :name, immutable: true
  validates :email, immutable: true
  validates :login, immutable: true

  has_one :leader
  has_many :teams
  has_many :gears
  has_many :ftbfs, class_name: 'Ftbfs'

  attr_accessible :name, :email, :login, :team, :time_zone, :jabber, :info, :location, :website

  def to_param
    login
  end

  def self.login_exists?(login)
    Maintainer.where(login: login.downcase, team: false).count > 0
  end

  # TODO: move Maintainer team info in MaintainerTeam model with all stuff
  def self.team_exists?(team_login)
    Maintainer.where(login: team_login.downcase, team: true).count > 0
  end

  def self.import(maintainer)
    name = maintainer.split('<')[0].chomp
    name.strip!
    email = maintainer.chop.split('<')[1]
    email.downcase!
    email = Maintainer.new.fix_maintainer_email(email)
    login = email.split('@')[0]
    domain = email.split('@')[1]
    if domain == 'altlinux.org'
      unless login_exists?(login)
        Maintainer.create(team: false, login: login, name: name, email: email)
      end
    else
      unless team_exists?(login)
        Maintainer.create(team: true, login: login, name: name, email: email)
      end
    end
  end

  def self.top15(branch)
    maintainers = []

    Maintainer.where(team: false).select('login, name').each do |maintainer|
      m = [maintainer.login, maintainer.name, $redis.smembers("#{branch.name}:maintainers:#{maintainer.login}").count]
      maintainers << m
    end

    maintainers.sort! { |a, b| b[2] <=> a[2] }
    maintainers[0..14]
  end
end
