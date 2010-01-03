namespace :"40" do
desc "Import all ACL for packages from 4.0 to database"
task :acls => :environment do
  require 'open-uri'

  puts "import acls"
  puts Time.now

  Acl.update_from_uri "http://git.altlinux.org/acl/list.packages.4.0", "4.0", "ALT Linux"

  puts Time.now
end
end
