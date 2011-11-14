# encoding: utf-8

class Obsolete < ActiveRecord::Base
  belongs_to :package

  validates :package, presence: true
  validates :name, presence: true

  def self.import_obsoletes(rpm, package)
    rpm.obsoletes.each do |o|
      obsolete = Obsolete.new
      obsolete.package = package
      obsolete.name = o.name
      obsolete.version = o.version.v
      obsolete.release = o.version.r
      obsolete.epoch = o.version.e
      obsolete.flags = o.flags
      obsolete.save!
    end
  end
end
