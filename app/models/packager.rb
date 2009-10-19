class Packager < ActiveRecord::Base
  validates_presence_of :name, :email, :login
  validates_uniqueness_of :login
#  validates_uniqueness_of :email, :login
  # packager_id
  has_many :acls, :order => "package ASC"
  has_many :srpms, :through => :acls, :order => "name ASC"
end
