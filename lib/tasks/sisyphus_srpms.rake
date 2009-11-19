require 'rpm'

namespace :sisyphus do
desc "Import src.rpm from Sisyphus to database"
task :srpms => :environment do
  puts "import src.rpm's"
  puts Time.now

  branch = Branch.find :first, :conditions => { :urlname => 'Sisyphus' }

  Dir.glob(branch.srpms_path).each do |file|
  begin
    rpm = RPM::Package::open(file)
    srpm = Srpm.new
    srpm.filename = rpm.name + '-' + rpm.version.v + '-' + rpm.version.r + '.src.rpm'
    srpm.name = rpm.name
    srpm.version = rpm.version.v
    srpm.release = rpm.version.r

    group = Group.find :first, :conditions => { :name => rpm[1016], :branch => branch.urlname }

    srpm.group_id = group.id

#    srpm.group = rpm[1016]

    packager = rpm[1015]
    packager_name = packager.split('<')[0].chomp
    packager_name.strip!
    packager_email = packager.chop.split('<')[1]

    packager_email.downcase!

    packager_email.gsub!(' at altlinux.ru', '@altlinux.org')
    packager_email.gsub!(' at altlinux.org', '@altlinux.org')
    packager_email.gsub!(' at altlinux dot org', '@altlinux.org')
    packager_email.gsub!(' at altlinux dot ru', '@altlinux.org')
    packager_email.gsub!(' at packages.altlinux.org', '@packages.altlinux.org')
    packager_email.gsub!(' at packages.altlinux.ru', '@packages.altlinux.org')
    packager_email.gsub!('@packages.altlinux.ru', '@packages.altlinux.org')

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
    srpm.epoch = rpm[1003]
    srpm.summary = rpm[1004]
    srpm.license = rpm[1014]
    srpm.url = rpm[1020]
    srpm.description = rpm[1005]
    srpm.vendor = rpm[1011]
    srpm.distribution = rpm[1010]
    srpm.buildtime = Time.at(rpm[1006])
    srpm.size = File.size(file)
    srpm.branch_id = branch.id
#    srpm.rawspec = 'TODO'

    srpm.status = 'current'

    srpm.save!

  rescue RuntimeError
    puts "Bad src.rpm -- " + file
#    puts srpm.group_id
#    puts rpm[1016]
  end
  end

  puts Time.now
end
end
