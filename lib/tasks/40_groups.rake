namespace :"40" do
desc "Import RPM groups for 4.0 to database"
task :groups => :environment do
  require 'open-uri'

  puts "import groups"
  puts Time.now

  Group.update_from_gitalt "ALT Linux", "4.0"

  puts Time.now
end
end
