require 'rpm'

namespace :"50" do
task :x86_64 => :environment do
  puts "import x86_64.rpm's"
  puts Time.now

  branch = Branch.find :first, :conditions => { :urlname => '5.0' }

  Dir.glob(branch.binary_x86_64_path).each do |file|
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

    packager = rpm[1015]
    packager_name = packager.split('<')[0].chomp
    packager_email = packager.chop.split('<')[1]

    packager_email = packager_email.downcase

    packager_email = packager_email.gsub(' at altlinux.ru', '@altlinux.org')
    packager_email = packager_email.gsub(' at altlinux.org', '@altlinux.org')
    packager_email = packager_email.gsub(' at altlinux dot org', '@altlinux.org')
    packager_email = packager_email.gsub(' at altlinux dot ru', '@altlinux.org')
    packager_email = packager_email.gsub(' at packages.altlinux.org', '@packages.altlinux.org')
    packager_email = packager_email.gsub(' at packages.altlinux.ru', '@packages.altlinux.org')
    packager_email = packager_email.gsub('@packages.altlinux.ru', '@packages.altlinux.org')

    packager_login = packager_email.split('@')[0]
    packager_domain = packager_email.split('@')[1]

    packager2 = Packager.new

    if packager_domain == 'packages.altlinux.org'
      team = true
      Packager.create(:team => true, :login => '@' + packager_login, :name => packager_name, :email => packager_email)
    else
      team = false
      Packager.create(:team => false, :login => packager_login, :name => packager_name, :email => packager_email)
    end

    if team == true
      packager3 = Packager.find :first, :conditions => { :login => '@' + packager_login }
    else
      packager3 = Packager.find :first, :conditions => { :login => packager_login }
    end

    package.packager_id = packager3.id
    package.epoch = rpm[1003]
    package.summary = rpm[1004]
    package.summary = 'Broken' if rpm.name == 'openmoko_dfu-util'
    package.license = rpm[1014]
    package.url = rpm[1020]
    package.description = rpm[1005]
    package.vendor = rpm[1011]
    package.distribution = rpm[1010]
    package.buildtime = Time.at(rpm[1006])
    package.size = File.size(file)
    package.branch = branch.urlname

    package.save!
  rescue RuntimeError
    puts "Bad src.rpm " + file
  end
  end

  puts Time.now
end
end
