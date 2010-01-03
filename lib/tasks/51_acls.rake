namespace :"51" do
desc "Import all ACL for packages from 5.1 to database"
task :acls => :environment do
  require 'open-uri'

  puts "import acls"
  puts Time.now

  Acl.update_from_uri "http://git.altlinux.org/acl/list.packages.5.1", "5.1", "ALT Linux"

  puts Time.now
end
end
