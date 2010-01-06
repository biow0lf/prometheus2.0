class Gitrepo < ActiveRecord::Base
  validates_presence_of :repo, :login, :lastchange
end
