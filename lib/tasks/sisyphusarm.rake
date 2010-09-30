namespace :sisyphusarm do
  desc "Import RPM groups for Sisyphus ARM to database"
  task :groups => :environment do
    require 'open-uri'
    puts Time.now.to_s + ": import RPM groups for Sisyphus ARM to database"
    Group.import_groups 'ALT Linux', 'SisyphusARM', 'http://git.altlinux.org/gears/r/rpm.git?p=rpm.git;a=blob_plain;f=GROUPS'
    puts Time.now.to_s + ": end"
  end

  desc "Import *.src.rpm from Sisyphus ARM to database"
  task :srpms => :environment do
    require 'rpm'
    require 'open-uri'
    puts Time.now.to_s + ": import *.src.rpm from Sisyphus ARM to database"
    Srpm.import_srpms 'ALT Linux', 'SisyphusARM', "/ALT/Sisyphus/arm/SRPMS.all/*.src.rpm"
    puts Time.now.to_s + ": end"
  end

  desc "Import binary *.rpm from Sisyphus ARM to database"
  task :binary => :environment do
    require 'rpm'
    puts Time.now.to_s + ": import binary *.rpm from Sisyphus ARM to database"
    Package.import_packages_arm 'ALT Linux', 'SisyphusARM', "/ALT/Sisyphus/files/arm/RPMS/*.rpm"
    puts Time.now.to_s + ": end"
  end
end