namespace :"51" do
desc "Import all ACL for packages from 5.1 to database"
task :acls => :environment do
  require 'open-uri'

  puts "import acls"
  puts Time.now

  Acl.update_from_gitalt "ALT Linux", "5.1"

  puts Time.now
end
end
