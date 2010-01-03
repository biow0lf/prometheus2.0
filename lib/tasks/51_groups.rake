namespace :"51" do
desc "Import RPM groups for 5.1 to database"
task :groups => :environment do
  require 'open-uri'

  puts "import groups"
  puts Time.now

  Group.update_from_gitalt "ALT Linux", "5.1"

  puts Time.now
end
end
