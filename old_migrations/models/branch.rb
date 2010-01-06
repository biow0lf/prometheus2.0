class Branch < ActiveRecord::Base
  validates_presence_of :fullname, :urlname
  has_many :srpms
  has_many :packages
  has_many :acls
  has_many :leaders
  has_many :groups
end
