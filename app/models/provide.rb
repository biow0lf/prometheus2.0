class Provide < ActiveRecord::Base
  validates :package_id, :presence => true
  validates :name, :presence => true
end
