namespace :t6 do
  desc 'Import RPM groups for t6 to database'
  task :groups => :environment do
    require 'open-uri'
    puts "#{Time.now.to_s}: import RPM groups for t6 to database"
    Group.import_groups('ALT Linux', 't6', 'http://git.altlinux.org/gears/r/rpm.git?p=rpm.git;a=blob_plain;f=GROUPS')
    puts "#{Time.now.to_s}: end"
  end
end
