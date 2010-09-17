class Gitrepo < ActiveRecord::Base
  validates_presence_of :repo, :login, :lastchange
  belongs_to :packager, :foreign_key => 'login', :primary_key => 'login'
end