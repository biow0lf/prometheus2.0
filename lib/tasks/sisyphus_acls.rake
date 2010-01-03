namespace :sisyphus do
desc "Import all ACL for packages from Sisyphus to database"
task :acls => :environment do
  require 'open-uri'

  puts "import acls"
  puts Time.now

  Acl.update_from_uri "http://git.altlinux.org/acl/list.packages.sisyphus", "Sisyphus", "ALT Linux"

  puts Time.now
end
end
