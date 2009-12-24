class Group < ActiveRecord::Base
  validates_presence_of :name, :branch
#  belongs_to :branch
  has_many :srpms, :order => "name ASC"

  def self.find_groups_in_sisyphus
    find_by_sql("SELECT COUNT(srpms.name) AS counter, groups.name
                 FROM srpms, groups, branches
                 WHERE groups.branch = branches.urlname
                 AND branches.urlname = 'Sisyphus'
                 AND srpms.group = groups.name
                 AND srpms.branch = branches.urlname
                 GROUP BY groups.name
                 ORDER BY groups.name")
  end

end
