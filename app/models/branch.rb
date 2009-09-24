class Branch < ActiveRecord::Base
  validates_presence_of :fullname, :urlname
end
