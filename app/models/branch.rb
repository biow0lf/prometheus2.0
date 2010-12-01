class Branch < ActiveRecord::Base
  validates :name, :presence => true
  validates :vendor, :presence => true

  has_many :acls
  has_many :srpms
  has_many :packages
  has_many :groups
  has_many :leaders
  has_many :teams
end
