# frozen_string_literal: true

class Changelog < ApplicationRecord
  PROPS = %i(changelogtime changelogname changelogtext)

  belongs_to :srpm

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

  def self.import_from file, srpm
    changelogs = RPM::Base.new(file).change_log

    attrs = changelogs.map { |line| [ PROPS, line ].transpose.to_h.merge(srpm_id: srpm.id) }

    Changelog.import(attrs)
  end
end
