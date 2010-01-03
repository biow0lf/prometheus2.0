namespace :platform5 do
desc "Import all ACL for packages from Platform5 to database"
task :acls => :environment do
  require 'open-uri'

  puts "import acls"
  puts Time.now

  Acl.update_from_uri "http://git.altlinux.org/acl/list.packages.p5", "Platform5", "ALT Linux"

  puts Time.now
end
end
