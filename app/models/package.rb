class Package < ActiveRecord::Base



  def self.import_packages_i586(vendor, branch)
    path = Branch.first :conditions => { :vendor => vendor, :name => branch }

    Dir.glob(path.binary_x86_path).each do |file|
    begin
      rpm = RPM::Package::open(file)
      package = Package.new
      package.filename = rpm.name + '-' + rpm.version.v + '-' + rpm.version.r + '.i586.rpm'
      package.sourcepackage = rpm[1044]
      package.name = rpm.name
      package.version = rpm.version.v
      package.release = rpm.version.r
      package.arch = rpm.arch
      package.group = rpm[1016]
      package.epoch = rpm[1003]
      package.summary = rpm[1004]
      package.summary = 'Broken' if rpm.name == 'openmoko_dfu-util'
      package.license = rpm[1014]
      package.url = rpm[1020]
      package.description = rpm[1005]
      package.buildtime = Time.at(rpm[1006])
      package.size = File.size(file)
      package.branch = branch
      package.vendor = vendor
      package.save!
    rescue RuntimeError
      puts "Bad src.rpm " + file
    end
    end
  end

  def self.import_packages_noarch(vendor, branch)
    path = Branch.first :conditions => { :vendor => vendor, :name => branch }

    Dir.glob(path.noarch_path).each do |file|
    begin
      rpm = RPM::Package::open(file)
      package = Package.new
      package.filename = rpm.name + '-' + rpm.version.v + '-' + rpm.version.r + '.noarch.rpm'
      package.sourcepackage = rpm[1044]
      package.name = rpm.name
      package.version = rpm.version.v
      package.release = rpm.version.r
      package.arch = rpm.arch
      package.group = rpm[1016]
      package.epoch = rpm[1003]
      package.summary = rpm[1004]
      package.summary = 'Broken' if rpm.name == 'openmoko_dfu-util'
      package.license = rpm[1014]
      package.url = rpm[1020]
      package.description = rpm[1005]
      package.buildtime = Time.at(rpm[1006])
      package.size = File.size(file)
      package.branch = branch
      package.vendor = vendor
      package.save!
    rescue RuntimeError
      puts "Bad src.rpm " + file
    end
    end
  end

  def self.import_packages_x86_64(vendor, branch)
    path = Branch.first :conditions => { :vendor => vendor, :name => branch }

    Dir.glob(path.binary_x86_64_path).each do |file|
    begin
      rpm = RPM::Package::open(file)
      package = Package.new
      package.filename = rpm.name + '-' + rpm.version.v + '-' + rpm.version.r + '.x86_64.rpm'
      package.sourcepackage = rpm[1044]
      package.name = rpm.name
      package.version = rpm.version.v
      package.release = rpm.version.r
      package.arch = rpm.arch
      package.group = rpm[1016]
      package.epoch = rpm[1003]
      package.summary = rpm[1004]
      package.summary = 'Broken' if rpm.name == 'openmoko_dfu-util'
      package.license = rpm[1014]
      package.url = rpm[1020]
      package.description = rpm[1005]
      package.buildtime = Time.at(rpm[1006])
      package.size = File.size(file)
      package.branch = branch
      package.vendor = vendor
      package.save!
    rescue RuntimeError
      puts "Bad src.rpm " + file
    end
    end
  end

end
