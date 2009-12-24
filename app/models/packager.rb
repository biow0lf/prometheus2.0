class Packager < ActiveRecord::Base
  validates_presence_of :name, :email, :login
  validates_uniqueness_of :login
#  validates_uniqueness_of :email, :login
  # packager_id
  has_many :acls, :order => "package ASC"
  has_many :srpms, :through => :acls, :order => "name ASC"

  def self.top15
    find_by_sql("SELECT COUNT(acls.package) AS counter,
                        packagers.name AS name,
                        packagers.login AS login
                 FROM acls, packagers, branches
                 WHERE packagers.login = acls.login
                 AND packagers.team = false
                 AND branches.urlname = 'Sisyphus'
                 AND acls.branch_id = branches.id
                 GROUP BY packagers.name, packagers.login
                 ORDER BY 1 DESC LIMIT 15")
  end

end
