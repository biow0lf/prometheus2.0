class Changelog < ActiveRecord::Base
  belongs_to :srpm

  validates :srpm, :presence => true
  validates :changelogtime, :presence => true
  validates :changelogname, :presence => true
  validates :changelogtext, :presence => true
end
