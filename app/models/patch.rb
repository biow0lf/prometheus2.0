class Patch < ActiveRecord::Base
  validates :srpm_id, :presence => true
  validates :branch_id, :presence => true
  validates :patch, :presence => true

  belongs_to :branch
  belongs_to :srpm
end
