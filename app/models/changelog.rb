class Changelog < ActiveRecord::Base
  validates_presence_of :srpm_id, :changelogtime, :changelogname, :changelogtext
  belongs_to :srpm
end