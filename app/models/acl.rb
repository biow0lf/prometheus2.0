class Acl < ActiveRecord::Base
  validates_presence_of :package, :login, :branch
  belongs_to :packager
end
