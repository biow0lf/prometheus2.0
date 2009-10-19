class Acl < ActiveRecord::Base
#  validates_presence_of :package, :login, :branch, :packager_id
  validates_presence_of :package, :login, :branch

  belongs_to :packager
  belongs_to :srpm
#  belongs_to :repocop
end
