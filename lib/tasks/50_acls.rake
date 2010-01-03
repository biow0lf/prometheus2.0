namespace :"50" do
desc "Import all ACL for packages from 5.0 to database"
task :acls => :environment do
  require 'open-uri'

  puts "import acls"
  puts Time.now

  Acl.update_from_uri "http://git.altlinux.org/acl/list.packages.5.0", "5.0", "ALT Linux"

  puts Time.now
end
end
