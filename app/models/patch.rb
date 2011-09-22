class Patch < ActiveRecord::Base
  belongs_to :branch
  belongs_to :srpm

  validates :srpm, presence: true
  validates :branch, presence: true
  validates :patch, presence: true
end
