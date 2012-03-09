# encoding: utf-8

class Changelog < ActiveRecord::Base
  belongs_to :srpm

  validates :srpm, presence: true
  validates :changelogtime, presence: true
  validates :changelogname, presence: true
  validates :changelogtext, presence: true

  define_index do
    # indexes changelogtime, :sortable => true
    indexes changelogtext

    set_property :delta => :datetime, :threshold => 1.hour
  end

  def self.import(branch, file, srpm)
    changelogs = `export LANG=C && rpm -qp --queryformat='[%{CHANGELOGTIME}\n**********\n%{CHANGELOGNAME}\n**********\n%{CHANGELOGTEXT}\n**********\n]' #{file}`
    changelogs.force_encoding('binary')
    changelogs = changelogs.split("\n**********\n")
    while !changelogs.empty?
      record = changelogs.slice!(0..2)
      changelog = Changelog.new
      changelog.srpm_id = srpm.id
      changelog.changelogtime = record[0]
      changelog.changelogname = record[1]
      changelog.changelogtext = record[2]
      changelog.save
    end
  end
end
