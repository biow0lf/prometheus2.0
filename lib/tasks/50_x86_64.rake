require 'rpm'

namespace :"50" do
task :x86_64 => :environment do
  puts "import x86_64.rpm's"
  puts Time.now

  branch = Branch.find :first, :conditions => { :urlname => '5.0' }

  Dir.glob(branch.binary_x86_64_path).each do |f|
  begin
    r = RPM::Package::open(f)
    package = Package.new
    package.filename = r.name + '-' + r.version.v + '-' + r.version.r + '.x86_64.rpm'
    package.sourcepackage = r[1044]
    package.name = r.name
    package.version = r.version.v
    package.release = r.version.r
    package.arch = r.arch
    package.group = r[1016]

    packager = r[1015]
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
    package.epoch = r[1003]
    package.summary = r[1004]
    package.summary = 'Broken' if r.name == 'openmoko_dfu-util'
    package.license = r[1014]
    package.url = r[1020]
    package.description = r[1005]
    package.vendor = r[1011]
    package.distribution = r[1010]
    package.buildtime = Time.at(r[1006])
    package.size = File.size(f)
    #package.branch = 'Sisyphus'
    package.branch_id = branch.id

    package.save!
  rescue RuntimeError
    puts "Bad src.rpm " + f
  end
  end

  puts Time.now
end
end
