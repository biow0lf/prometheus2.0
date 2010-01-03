namespace :platform5 do
desc "Import RPM groups for Platform5 to database"
task :groups => :environment do
  require 'open-uri'

  puts "import groups"
  puts Time.now

  Group.update_from_gitalt "ALT Linux", "Platform5"

  puts Time.now
end
end
