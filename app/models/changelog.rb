class Changelog < ApplicationRecord
  belongs_to :srpm

  validates :srpm, presence: true

  validates :changelogtime, presence: true

  validates :changelogname, presence: true

  validates :changelogtext, presence: true

  def email
    # TODO: add test for this
    FixMaintainerEmail.new(changelogname.slice(/<.+>/)[1..-2]).execute
  rescue
    nil
  end

  def login
    return unless email
    email.split('@').first
  end

  def self.import(file, srpm)
    changelogs = `export LANG=C && rpm -qp --queryformat='[%{CHANGELOGTIME}\n**********\n%{CHANGELOGNAME}\n**********\n%{CHANGELOGTEXT}\n**********\n]' #{ file }`
    changelogs.force_encoding('binary')
    changelogs = changelogs.split("\n**********\n")
    while !changelogs.empty?
      record = changelogs.slice!(0..2)
      changelog = Changelog.new
      changelog.srpm_id = srpm.id
      changelog.changelogtime = record[0]
      changelog.changelogname = record[1]
      changelog.changelogtext = record[2]
      changelog.save!
    end
  end
end
