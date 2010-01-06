class Leader < ActiveRecord::Base
  validates_presence_of :package, :login, :branch_id
  belongs_to :branch
end
