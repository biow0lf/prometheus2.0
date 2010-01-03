namespace :"41" do
desc "Import RPM groups for 4.1 to database"
task :groups => :environment do
  require 'open-uri'

  puts "import groups"
  puts Time.now

  Group.update_from_uri "http://git.altlinux.org/gears/r/rpm.git?p=rpm.git;a=blob_plain;f=GROUPS", "4.1", "ALT Linux" 

  puts Time.now
end
end
