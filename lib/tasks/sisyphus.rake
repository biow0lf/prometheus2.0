namespace :sisyphus do
desc "Import all ACL for packages from Sisyphus to database"
task :acls => :environment do
  require 'open-uri'

  puts "import acls"
  puts Time.now

  Acl.update_from_gitalt "ALT Linux", "Sisyphus"

  puts Time.now
end

desc "Import RPM groups for Sisyphus to database"
task :groups => :environment do
  require 'open-uri'

  puts "import groups"
  puts Time.now

  Group.update_from_gitalt "ALT Linux", "Sisyphus"

  puts Time.now
end

desc "Import src.rpm from Sisyphus to database"
task :srpms => :environment do
  require 'rpm'

  puts "import src.rpm's"
  puts Time.now

  Srpm.import_srpms "ALT Linux", "Sisyphus"

  puts Time.now
end

task :i586 => :environment do
  require 'rpm'

  puts "import i586.rpm's"
  puts Time.now

  Package.update_packages_i586 'ALT Linux', 'Sisyphus'

  puts Time.now
end

task :noarch => :environment do
  require 'rpm'

  puts "import noarch.rpm's"
  puts Time.now

  Package.update_packages_noarch 'ALT Linux', 'Sisyphus'

  puts Time.now
end

task :x86_64 => :environment do
  require 'rpm'

  puts "import x86_64.rpm's"
  puts Time.now

  Package.update_packages_x86_64 'ALT Linux', 'Sisyphus'

  puts Time.now
end

desc "Import all ACL for packages from Sisyphus to database (leaders)"
task :leaders => :environment do
  require 'open-uri'

  puts "import leaders"
  puts Time.now

  Leader.update_from_gitalt "ALT Linux", "Sisyphus"

  puts Time.now
end

end
