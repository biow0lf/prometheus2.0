class Freshmeat < ApplicationRecord
  validates :name, presence: true

  validates :version, presence: true
end
