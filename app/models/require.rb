class Require < ActiveRecord::Base
  belongs_to :package

  validates :package, presence: true
  validates :name, presence: true

  attr_accessible :package_id, :name, :version, :release, :epoch, :flags

# FIXME: this code is broken
#  def self.import_requires(rpm, package)
#    rpm.requires.each do |r|
#      req = Require.new
#      req.package = package
#      req.name = r.name
#      req.version = r.version.v
#      req.release = r.version.r
#      req.epoch = r.version.e
#      req.flags = r.flags
#      req.save!
#    end
#  end
end
