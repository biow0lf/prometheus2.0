namespace :"50" do
desc "Import RPM groups for 5.0 to database"
task :groups => :environment do
  require 'open-uri'

  puts "import groups"
  puts Time.now

  Group.update_from_uri "http://git.altlinux.org/gears/r/rpm.git?p=rpm.git;a=blob_plain;f=GROUPS", "5.0", "ALT Linux"

  puts Time.now
end
end
