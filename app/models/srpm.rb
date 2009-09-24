class Srpm < ActiveRecord::Base
#  validates_presence_of :filename, :name, :version, :release, :packager_id, :group_id, :summary, :license, :description, :vendor, :distribution, :branch, :buildtime, :rawspec, :size

# FIXME: vendor and distribution must be not ''
#  validates_presence_of :filename, :name, :version, :release, :packager_id, :group, :summary, :license, :description, :branch, :buildtime, :rawspec, :size
#  validates_presence_of :filename, :name, :version, :release, :group, :summary, :license, :description, :branch, :buildtime, :rawspec, :size
  validates_presence_of :filename, :name, :version, :release, :group, :summary, :license, :branch, :buildtime, :rawspec, :size
#  belongs_to :group
  belongs_to :packager
end
