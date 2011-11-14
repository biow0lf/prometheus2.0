# encoding: utf-8

# namespace :"50" do
#   desc "Import all ACL for packages from 5.0 to database"
#   task :acls => :environment do
#     require 'open-uri'
#     puts Time.now.to_s + ": import acls"
#     Acl.import_acls 'ALT Linux', '5.0', 'http://git.altlinux.org/acl/list.packages.5.0'
#     puts Time.now.to_s + ": end"
#   end
# 
#   desc "Import *.src.rpm from 5.0 to database"
#   task :srpms => :environment do
#     require 'rpm'
#     puts Time.now.to_s + ": import src.rpm's"
#     Srpm.import_srpms 'ALT Linux', '5.0', "/ALT/5.0/files/SRPMS/*.src.rpm"
#     puts Time.now.to_s + ": end"
#   end
# 
#   desc "Import *.i586.rpm from 5.0 to database"
#   task :i586 => :environment do
#     require 'rpm'
#     puts Time.now.to_s + ": import i586.rpm's"
#     Package.import_packages_i586 'ALT Linux', '5.0', "/ALT/5.0/files/i586/RPMS/*.i586.rpm"
#     puts Time.now.to_s + ": end"
#   end
# 
#   desc "Import *.noarch.rpm from 5.0 to database"
#   task :noarch => :environment do
#     require 'rpm'
#     puts Time.now.to_s + ": import noarch.rpm's"
#     Package.import_packages_noarch 'ALT Linux', '5.0', "/ALT/5.0/files/noarch/RPMS/*.noarch.rpm"
#     puts Time.now.to_s + ": end"
#   end
# 
#   desc "Import *.x86_64.rpm from 5.0 to database"
#   task :x86_64 => :environment do
#     require 'rpm'
#     puts Time.now.to_s + ": import x86_64.rpm's"
#     Package.import_packages_x86_64 'ALT Linux', '5.0', "/ALT/5.0/files/x86_64/RPMS/*.x86_64.rpm"
#     puts Time.now.to_s + ": end"
#   end
# 
#   desc "Import all ACL for packages from 5.0 to database (leaders)"
#   task :leaders => :environment do
#     require 'open-uri'
#     puts Time.now.to_s + ": import leaders"
#     Leader.import_leaders 'ALT Linux', '5.0', 'http://git.altlinux.org/acl/list.packages.5.0'
#     puts Time.now.to_s + ": end"
#   end
# 
#   desc "Import all teams from 5.0 to database"
#   task :teams => :environment do
#     require 'open-uri'
#     puts Time.now.to_s + ": import teams"
#     Team.import_teams 'ALT Linux', '5.0', 'http://git.altlinux.org/acl/list.groups.5.0'
#     puts Time.now.to_s + ": end"
#   end
# end