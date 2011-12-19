# encoding: utf-8

class Changelog < ActiveRecord::Base
  belongs_to :srpm

  validates :srpm, presence: true
  validates :changelogtime, presence: true
  validates :changelogname, presence: true
  validates :changelogtext, presence: true

  def self.import(branch, file, srpm)
    changelogs = `export LANG=C && rpm -qp --queryformat='[%{CHANGELOGTIME}\n**********\n%{CHANGELOGNAME}\n**********\n%{CHANGELOGTEXT}\n**********\n]' #{file}`
    index = 0
    counter = 0
    changelog = Changelog.new
    changelogs.split("\n**********\n").each do |item|
      counter += 1
      if index == 0
        changelog = Changelog.new
        changelog.srpm_id = srpm.id
        changelog.changelogtime = item
        index = 1
      elsif index == 1
        changelog.changelogname = item.force_encoding('binary')
        index = 2
      elsif index == 2
        changelog.changelogtext = item.force_encoding('binary')
        changelog.save
        index = 0
      end
    end
  end
end
