class Branch < ActiveRecord::Base
  validates_presence_of :vendor, :name, :url
end
