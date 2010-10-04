class Gitrepo < ActiveRecord::Base
  validates_presence_of :repo, :login, :lastchange
  belongs_to :maintainer, :foreign_key => 'login', :primary_key => 'login'
end