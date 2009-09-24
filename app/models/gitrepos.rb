class Gitrepos < ActiveRecord::Base
  validates_presence_of :package, :login, :lastchange
end
