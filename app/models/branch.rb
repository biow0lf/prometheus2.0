class Branch < ActiveRecord::Base
  validates_presence_of :vendor, :name, :url
  has_many :acls
end