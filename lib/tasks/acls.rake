require 'open-uri'

namespace :sisyphus do
desc "Import all ACL for packages from Sisyphus to database"
task :acls => :environment do
  puts "import acls"
  puts Time.now

  Acl.transaction do
    Acl.delete_all

    url = "http://git.altlinux.org/acl/list.packages.sisyphus"
    f = open(URI.escape(url)).read

    f.each_line do |line|
      package = line.split[0]
      #(1..line.split.count).each do |i|
      for i in 1..line.split.count-1
        login = line.split[i]
        login = 'php-coder' if login == 'php_coder'
        Acl.create(:package => package, :login => login, :branch => 'Sisyphus')
      end
    end
  end
  puts Time.now
end
end
