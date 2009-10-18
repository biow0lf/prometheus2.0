require 'rpm'

namespace :sisyphus do
task :srpms => :environment do
  puts Time.now
  puts "import src.rpm's"

  Dir.glob("/path/to/*.src.rpm").each do |f|
  begin
    r = RPM::Package::open(f)
    srpm = Srpm.new
    srpm.filename = r.name + '-' + r.version.v + '-' + r.version.r + '.src.rpm'
    srpm.name = r.name
    srpm.version = r.version.v
    srpm.release = r.version.r
    srpm.group = r[1016]

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

    srpm.packager_id = packager3.id
    srpm.epoch = r[1003]
    srpm.summary = r[1004]
    srpm.license = r[1014]
    srpm.url = r[1020]
    srpm.description = r[1005]
    srpm.vendor = r[1011]
    srpm.distribution = r[1010]
    srpm.buildtime = Time.at(r[1006])
    srpm.size = File.size(f)
    srpm.branch = 'Sisyphus'
    srpm.rawspec = 'TODO'

    srpm.save!

  rescue RuntimeError
    puts "Bad src.rpm -- " + f
  end
  end

  puts Time.now
end
end
