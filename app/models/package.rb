class Package < ActiveRecord::Base



  def self.update_packages_i586(vendor, branch)
    br = Branch.first :conditions => { :vendor => 'ALT Linux', :name => 'Sisyphus' }

    Dir.glob(br.binary_x86_path).each do |file|
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
      package.license = rpm[1014]
      package.url = rpm[1020]
      package.description = rpm[1005]
      package.buildtime = Time.at(rpm[1006])
      package.size = File.size(file)
      package.branch = br.name
      package.save!
    rescue RuntimeError
      puts "Bad src.rpm " + file
    end
    end
  end

  def self.update_packages_noarch(vendor, branch)
    br = Branch.first :conditions => { :vendor => 'ALT Linux', :name => 'Sisyphus' }

    Dir.glob(br.noarch_path).each do |file|
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
      package.license = rpm[1014]
      package.url = rpm[1020]
      package.description = rpm[1005]
      package.buildtime = Time.at(rpm[1006])
      package.size = File.size(file)
      package.branch = br.name
      package.save!
    rescue RuntimeError
      puts "Bad src.rpm " + file
    end
    end
  end

  def self.update_packages_x86_64(vendor, branch)
    br = Branch.first :conditions => { :vendor => 'ALT Linux', :name => 'Sisyphus' }

    Dir.glob(br.binary_x86_64_path).each do |file|
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
      package.license = rpm[1014]
      package.url = rpm[1020]
      package.description = rpm[1005]
      package.buildtime = Time.at(rpm[1006])
      package.size = File.size(file)
      package.branch = br.name
      package.save!
    rescue RuntimeError
      puts "Bad src.rpm " + file
    end
    end
  end

end
