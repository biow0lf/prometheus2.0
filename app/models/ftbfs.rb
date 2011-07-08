class Ftbfs < ActiveRecord::Base
  belongs_to :branch
  validates :branch, :presence => true
  validates :name, :presence => true
  validates :version, :presence => true
  validates :release, :presence => true
  validates :weeks, :presence => true
  validates :arch, :presence => true

  def self.update_ftbfs(vendor_name, branch_name, url, arch)
    branch = Branch.where(:vendor => vendor_name, :name => branch_name).first
    file = open(URI.escape(url)).read
    file.each_line do |line|
      name = line.split[0]
      evr = line.split[1]
      weeks = line.split[2]
      if evr[/:/]
        epoch = evr.split(':')[0] if evr[/:/]
        version, release = evr.split(':')[1].split('-')
      else
        epoch = nil
        version, release = evr.split('-')
      end
      Ftbfs.create!(:name => name, :epoch => epoch, :version => version,
                    :release => release, :weeks => weeks, :branch => branch,
                    :arch => arch)
    end
  end
end
