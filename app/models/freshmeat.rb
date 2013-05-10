class Freshmeat < ActiveRecord::Base
  validates :name, presence: true
  validates :version, presence: true

  attr_accessible :name, :version
end
