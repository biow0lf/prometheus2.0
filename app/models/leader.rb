class Leader < ActiveRecord::Base
  validates_presence_of :package, :login, :branch
end
