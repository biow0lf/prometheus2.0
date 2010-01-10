namespace :"41" do
desc "Import all ACL for packages from 4.1 to database"
task :acls => :environment do
  require 'open-uri'
  puts Time.now.to_s + ": import acls"
  Acl.update_from_gitalt 'ALT Linux', '4.1'
  puts Time.now.to_s + ": end"
end

desc "Import RPM groups for 4.1 to database"
task :groups => :environment do
  require 'open-uri'
  puts Time.now.to_s + ": import groups"
  Group.update_from_gitalt 'ALT Linux', '4.1'
  puts Time.now.to_s + ": end"
end

desc "Import *.src.rpm from 4.1 to database"
task :srpms => :environment do
  require 'rpm'
  puts Time.now.to_s + ": import src.rpm's"
  Srpm.import_srpms 'ALT Linux', '4.1'
  puts Time.now.to_s + ": end"
end

desc "Import *.i586.rpm from 4.1 to database"
task :i586 => :environment do
  require 'rpm'
  puts Time.now.to_s + ": import i586.rpm's"
  Package.import_packages_i586 'ALT Linux', '4.1'
  puts Time.now.to_s + ": end"
end

desc "Import *.noarch.rpm from 4.1 to database"
task :noarch => :environment do
  require 'rpm'
  puts Time.now.to_s + ": import noarch.rpm's"
  Package.import_packages_noarch 'ALT Linux', '4.1'
  puts Time.now.to_s + ": end"
end

desc "Import *.x86_64.rpm from 4.1 to database"
task :x86_64 => :environment do
  require 'rpm'
  puts Time.now.to_s + ": import x86_64.rpm's"
  Package.import_packages_x86_64 'ALT Linux', '4.1'
  puts Time.now.to_s + ": end"
end

desc "Import all ACL for packages from 4.1 to database (leaders)"
task :leaders => :environment do
  require 'open-uri'
  puts Time.now.to_s + ": import leaders"
  Leader.update_from_gitalt 'ALT Linux', '4.1'
  puts Time.now.to_s + ": end"
end

desc "Import packagers list from src.rpm from 4.1 to database"
task :packagers => :environment do
  require 'rpm'
  puts Time.now.to_s + ": import src.rpm's"
  Packager.update_packager_list 'ALT Linux', '4.1'
  puts Time.now.to_s + ": end"
end

desc "Import all teams from 4.1 to database"
task :teams => :environment do
  require 'open-uri'
  puts Time.now.to_s + ": import teams"
  Team.update_from_gitalt 'ALT Linux', '4.1'
  puts Time.now.to_s + ": end"
end

end
