class Conflict < ActiveRecord::Base
  belongs_to :package

  validates :package, :presence => true
  validates :name, :presence => true

  def self.import_conflicts(rpm, package)
    rpm.conflicts.each do |c|
      conflict = Conflict.new
      conflict.package_id = package.id
      conflict.name = c.name
      conflict.version = c.version.v
      conflict.release = c.version.r
      conflict.epoch = c.version.e
      conflict.flags = c.flags
      conflict.save!
    end
  end
end
