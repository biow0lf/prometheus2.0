require 'open-uri'

desc "Import all ACL for packages from Sisyphus to database (leaders)"
task :leaders => :environment do
  puts "import leaders"
  puts Time.now

  Leader.transaction do
    Leader.delete_all

    url = "http://git.altlinux.org/acl/list.packages.sisyphus"
    f = open(URI.escape(url)).read

    f.each_line do |line|
      package = line.split[0]
      login = line.split[1]
      Leader.create(:package => package, :login => login, :branch => 'Sisyphus')
    end
  end
  puts Time.now
end

