namespace :platform6 do
  desc 'Import RPM groups for Platform6 to database'
  task :groups => :environment do
    require 'open-uri'
    puts "#{Time.now.to_s}: import RPM groups for Platform6 to database"
    Group.import_groups 'ALT Linux', 'Platform6', 'http://git.altlinux.org/gears/r/rpm.git?p=rpm.git;a=blob_plain;f=GROUPS'
    puts "#{Time.now.to_s}: end"
  end

  desc 'Import *.src.rpm from Platform6 to database'
  task :srpms => :environment do
    require 'rpm'
    puts "#{Time.now.to_s}: import *.src.rpm from Platform6 to database"
    Srpm.import_srpms 'ALT Linux', 'Platform6', '/ALT/p6/files/SRPMS/*.src.rpm'
    puts "#{Time.now.to_s}: end"
  end

end
