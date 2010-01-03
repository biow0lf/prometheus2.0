namespace :"41" do
desc "Import all ACL for packages from 4.1 to database"
task :acls => :environment do
  require 'open-uri'

  puts "import acls"
  puts Time.now

  Acl.update_from_uri "http://git.altlinux.org/acl/list.packages.4.1", "4.1", "ALT Linux"

  puts Time.now
end
end
