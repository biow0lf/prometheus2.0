namespace :sisyphus do
desc "Import all ACL for packages from Sisyphus to database"
task :acls => :environment do
  require 'open-uri'
  puts Time.now + ": import acls"
  Acl.update_from_gitalt "ALT Linux", "Sisyphus"
  puts Time.now + ": end"
end

desc "Import RPM groups for Sisyphus to database"
task :groups => :environment do
  require 'open-uri'
  puts Time.now + ": import groups"
  Group.update_from_gitalt "ALT Linux", "Sisyphus"
  puts Time.now + ": end"
end

desc "Import *.src.rpm from Sisyphus to database"
task :srpms => :environment do
  require 'rpm'
  puts Time.now + ": import src.rpm's"
  Srpm.import_srpms "ALT Linux", "Sisyphus"
  puts Time.now + ": end"
end

desc "Import *.i586.rpm from Sisyphus to database"
task :i586 => :environment do
  require 'rpm'
  puts Time.now + ": import i586.rpm's"
  Package.update_packages_i586 'ALT Linux', 'Sisyphus'
  puts Time.now + ": end"
end

desc "Import *.noarch.rpm from Sisyphus to database"
task :noarch => :environment do
  require 'rpm'
  puts Time.now + ": import noarch.rpm's"
  Package.update_packages_noarch 'ALT Linux', 'Sisyphus'
  puts Time.now + ": end"
end

desc "Import *.x86_64.rpm from Sisyphus to database"
task :x86_64 => :environment do
  require 'rpm'
  puts Time.now + ": import x86_64.rpm's"
  Package.update_packages_x86_64 'ALT Linux', 'Sisyphus'
  puts Time.now + ": end"
end

desc "Import all ACL for packages from Sisyphus to database (leaders)"
task :leaders => :environment do
  require 'open-uri'
  puts Time.now + ": import leaders"
  Leader.update_from_gitalt "ALT Linux", "Sisyphus"
  puts Time.now + ": end"
end

desc "Import packagers list from src.rpm from Sisyphus to database"
task :packagers => :environment do
  require 'rpm'
  puts Time.now + ": import src.rpm's"
  Packager.update_packager_list "ALT Linux", "Sisyphus"
  puts Time.now + ": end"
end

desc "Import all teams from Sisyphus to database"
task :teams => :environment do
  require 'open-uri'
  puts Time.now + ": import teams"
  Team.update_from_gitalt "ALT Linux", "Sisyphus"
  puts Time.now + ": end"
end

end
