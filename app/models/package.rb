class Package < ActiveRecord::Base
#  validates_presence_of :filename, :name, :version, :release, :arch, :packager_id, :group_id, :summary, :license, :description, :vendor, :distribution, :branch, :buildtime, :size

  # FIXME: vendor and distribution must be not ''
  validates_presence_of :filename, :name, :version, :release, :arch, :packager_id, :group, :summary, :license, :description, :branch, :buildtime, :size

#  belongs_to :group
  belongs_to :packager
  # has_many :requires
  # has_many :provides
  # has_many :obsoletes
  # has_many :rpmfiles
  # has_many :changelogs
end
