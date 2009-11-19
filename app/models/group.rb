class Group < ActiveRecord::Base
  validates_presence_of :name, :branch
#  belongs_to :branch
  has_many :srpms, :order => "name ASC"
end
