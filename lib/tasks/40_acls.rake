namespace :"40" do
desc "Import all ACL for packages from 4.0 to database"
task :acls => :environment do
  require 'open-uri'

  puts "import acls"
  puts Time.now

  Acl.update_from_gitalt "ALT Linux", "4.0"

  puts Time.now
end
end
