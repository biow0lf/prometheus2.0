namespace :sisyphus do
desc "Import all teams from Sisyphus to database"
task :teams => :environment do
  require 'open-uri'

  puts "import teams"
  puts Time.now

  Team.update_from_gitalt "ALT Linux", "Sisyphus"

  puts Time.now
end
end
