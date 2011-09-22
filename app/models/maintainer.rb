class Maintainer < ActiveRecord::Base
  include MaintainerHelper

  validates :name, presence: true
  validates :email, presence: true
  validates :login, presence: true, uniqueness: true

  validates :name, immutable: true
  validates :email, immutable: true
  validates :login, immutable: true

  has_one :leader
  has_many :acls
  has_many :teams
  has_many :srpms, through: :acls
  has_many :gears
  has_many :ftbfs, class_name: "Ftbfs"

  attr_accessible :name, :email, :login, :team, :time_zone, :jabber, :info

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

  def self.find_all_maintainers_in(branch_name)
    find_by_sql(["SELECT COUNT(acls.srpm_id) AS counter,
                        maintainers.name AS name,
                        maintainers.login AS login
                 FROM acls, maintainers, branches
                 WHERE maintainers.id = acls.maintainer_id
                 AND maintainers.team = 'false'
                 AND acls.branch_id = branches.id
                 AND branches.name = ?
                 AND branches.vendor = 'ALT Linux'
                 GROUP BY maintainers.name, maintainers.login
                 ORDER BY maintainers.name ASC", branch_name])
  end

  def self.find_all_teams_in(branch_name)
    find_by_sql(["SELECT COUNT(acls.srpm_id) AS counter,
                        maintainers.name AS name,
                        maintainers.login AS login
                 FROM acls, maintainers, branches
                 WHERE maintainers.id = acls.maintainer_id
                 AND maintainers.team = 'true'
                 AND acls.branch_id = branches.id
                 AND branches.name = ?
                 AND branches.vendor = 'ALT Linux'
                 GROUP BY maintainers.name, maintainers.login
                 ORDER BY maintainers.name ASC", branch_name])
  end

  def self.top15
    find_by_sql("SELECT COUNT(acls.srpm_id) AS counter,
                        maintainers.name AS name,
                        maintainers.login AS login
                 FROM branches, acls, maintainers
                 WHERE branches.name = 'Sisyphus'
                 AND branches.vendor = 'ALT Linux'
                 AND branches.id = acls.branch_id
                 AND acls.maintainer_id = maintainers.id
                 AND maintainers.team = 'false'
                 GROUP BY maintainers.name, maintainers.login
                 ORDER BY 1 DESC LIMIT 15")
  end
end
