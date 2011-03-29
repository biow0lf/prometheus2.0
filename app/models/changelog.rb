class Changelog < ActiveRecord::Base
  validates :srpm, :presence => true
  validates :changelogtime, :presence => true
  validates :changelogname, :presence => true
  validates :changelogtext, :presence => true

  belongs_to :srpm
end
