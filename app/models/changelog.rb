class Changelog < ActiveRecord::Base
  validates :srpm_id, :presence => true
  validates :changelogtime, :presence => true
  validates :changelogname, :presence => true
  validates :changelogtext, :presence => true

  belongs_to :srpm
end