namespace :sisyphus do
desc "Import all ACL for packages from Sisyphus to database"
task :acls => :environment do
  require 'open-uri'

  puts "import acls"
  puts Time.now

  Acl.update_from_gitalt "ALT Linux", "Sisyphus"

  puts Time.now
end
end
