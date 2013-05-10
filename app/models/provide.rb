class Provide < ActiveRecord::Base
  belongs_to :package

  validates :package, presence: true
  validates :name, presence: true

  attr_accessible :package_id, :name, :version, :release, :epoch, :flags

# FIXME: this code is broken
#  def self.import_provides(rpm, package)
#    rpm.provides.each do |p|
#      provide = Provide.new
#      provide.package = package
#      provide.name = p.name
#      provide.version = p.version.v
#      provide.release = p.version.r
#      provide.epoch = p.version.e
#      provide.flags = p.flags
#      provide.save!
#    end
#  end
end
