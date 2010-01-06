namespace :sisyphus do
desc "Import all ACL for packages from Sisyphus to database (leaders)"
task :leaders => :environment do
  require 'open-uri'

  puts "import leaders"
  puts Time.now

  Leader.update_from_gitalt "ALT Linux", "Sisyphus"

  puts Time.now
end
end
