namespace :sisyphus do
desc "Import RPM groups for Sisyphus to database"
task :groups => :environment do
  require 'open-uri'

  puts "import groups"
  puts Time.now

  Group.update_from_gitalt "ALT Linux", "Sisyphus"

  puts Time.now
end
end
