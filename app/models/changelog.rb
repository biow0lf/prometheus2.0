# frozen_string_literal: true

class Changelog < ApplicationRecord
   PROPS = %i(changelogtime changelogname changelogtext)

   belongs_to :package, class_name: 'Package::Src'

   validates_presence_of :changelogtime, :changelogname, :changelogtext

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

  def self.import_from rpm, package
    changelogs = rpm.change_log

    attrs = changelogs.map { |line| [ PROPS, line ].transpose.to_h.merge(package_id: package.id) }

    Changelog.import(attrs)
  end
end
