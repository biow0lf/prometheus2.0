class Packager < ActiveRecord::Base
  validates_presence_of :name, :email, :login
  validates_uniqueness_of :login
#  validates_uniqueness_of :email, :login
  has_many :acls
#  has_many :packages
#  has_many :srpms
end
