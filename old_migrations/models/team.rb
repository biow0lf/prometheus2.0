class Team < ActiveRecord::Base
  validates_presence_of :name, :login, :branch_id
end
