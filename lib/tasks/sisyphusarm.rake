namespace :sisyphusarm do
  desc "Import *.src.rpm from SisyphusARM to database"
  task :srpms => :environment do
    require 'open-uri'
    # FIXME: move this require to model
    require 'rpm'
    puts "#{Time.now.to_s}: import *.src.rpm from SisyphusARM to database"
    Srpm.import_srpms 'ALT Linux', 'SisyphusARM', '/ALT/Sisyphus/arm/SRPMS.all/*.src.rpm'
    puts "#{Time.now.to_s}: end"
  end

  desc "Import binary *.arm.rpm/*.noarch.rpm from SisyphusARM to database"
  task :binary => :environment do
    # FIXME: move this require to model
    require 'rpm'
    puts "#{Time.now.to_s}: import binary *.arm.rpm/*.noarch.rpm from SisyphusARM to database"
    Package.import_packages_arm 'ALT Linux', 'SisyphusARM', '/ALT/Sisyphus/files/arm/RPMS/*.rpm'
    puts "#{Time.now.to_s}: end"
  end
end
