namespace :sisyphus do
desc "Import repocop reports to database"
task :repocops => :environment do
  require 'open-uri'

  puts "import repocop reports"
  puts Time.now

  Repocop.update_repocop

  puts Time.now
end
end
