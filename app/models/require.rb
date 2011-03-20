class Require < ActiveRecord::Base
  validates :package_id, :presence => true
  validates :name, :presence => true

  def self.import_requires(rpm, package)
    rpm.requires.each do |r|
      req = Require.new
      req.package_id = package.id
      req.name = r.name
      req.version = r.version.v
      req.release = r.version.r
      req.epoch = r.version.e
      req.flags = r.flags
      req.save!
    end
  end
end
