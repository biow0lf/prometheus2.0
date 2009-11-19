class Srpm < ActiveRecord::Base
#  validates_presence_of :filename, :name, :version, :release, :packager_id, :group_id, :summary, :license, :description, :vendor, :distribution, :branch, :buildtime, :rawspec, :size

# FIXME: vendor and distribution must be not ''
#  validates_presence_of :filename, :name, :version, :release, :packager_id, :group, :summary, :license, :description, :branch, :buildtime, :rawspec, :size
#  validates_presence_of :filename, :name, :version, :release, :group, :summary, :license, :description, :branch, :buildtime, :rawspec, :size
#  validates_presence_of :filename, :name, :version, :release, :group, :summary, :license, :branch, :buildtime, :rawspec, :size
#  validates_presence_of :filename, :name, :version, :release, :group_id, :summary, :license, :branch_id, :buildtime, :rawspec, :size

#  validates_presence_of :filename, :name, :version, :release, :group_id, :summary, :license, :branch_id, :buildtime, :size
  validates_presence_of :filename, :name, :version, :release, :group_id, :summary, :license, :branch, :buildtime, :size
#  belongs_to :group
  belongs_to :packager
#  belongs_to :branch
  has_many :acls
  belongs_to :group

  has_many :repocops, :finder_sql => 'SELECT * FROM repocops
                                      WHERE srcname = \'#{name}\'
                                      AND srcversion = \'#{version}\'
                                      AND srcrel = \'#{release}\''
  has_many :changelogs
end
