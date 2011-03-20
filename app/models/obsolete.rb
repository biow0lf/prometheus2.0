class Obsolete < ActiveRecord::Base
  validates :package_id, :presence => true
  validates :name, :presence => true

  def self.import_obsoletes(rpm, package)
    rpm.obsoletes.each do |o|
      obsolete = Obsolete.new
      obsolete.package_id = package.id
      obsolete.name = o.name
      obsolete.version = o.version.v
      obsolete.release = o.version.r
      obsolete.epoch = o.version.e
      obsolete.flags = o.flags
      obsolete.save!
    end
  end
end
