class Branch < ActiveRecord::Base
  validates_presence_of :vendor, :name, :url
  has_many :acls
  has_many :srpms
  has_many :packages
  has_many :groups
  has_many :leaders
  has_many :teams
end