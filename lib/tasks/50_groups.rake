namespace :"50" do
desc "Import RPM groups for 5.0 to database"
task :groups => :environment do
  require 'open-uri'

  puts "import groups"
  puts Time.now

  Group.update_from_gitalt "ALT Linux", "5.0"

  puts Time.now
end
end
