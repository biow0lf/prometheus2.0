class Freshmeat < ActiveRecord::Base
  validates :name, presence: true
  validates :version, presence: true
end
