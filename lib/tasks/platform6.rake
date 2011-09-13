# namespace :platform6 do
#   desc 'Import *.src.rpm from Platform6 to database'
#   task :srpms => :environment do
#     require 'rpm'
#     puts "#{Time.now.to_s}: import *.src.rpm from Platform6 to database"
#     Srpm.import_srpms('ALT Linux', 'Platform6', '/ALT/p6/files/SRPMS/*.src.rpm')
#     puts "#{Time.now.to_s}: end"
#   end
# 
#   desc 'Import *.i586.rpm from Platform6 to database'
#   task :i586 => :environment do
#     require 'rpm'
#     puts "#{Time.now.to_s}: import *.i586.rpm from Platform6 to database"
#     Package.import_packages_i586('ALT Linux', 'Platform6', '/ALT/p6/files/i586/RPMS/*.i586.rpm')
#     puts "#{Time.now.to_s}: end"
#   end
# 
#   desc 'Import *.noarch.rpm from Platform6 to database'
#   task :noarch => :environment do
#     require 'rpm'
#     puts "#{Time.now.to_s}: import *.noarch.rpm from Platform6 to database"
#     Package.import_packages_noarch('ALT Linux', 'Platform6', '/ALT/p6/files/noarch/RPMS/*.noarch.rpm')
#     puts "#{Time.now.to_s}: end"
#   end
# 
#   desc 'Import *.x86_64.rpm from Platform6 to database'
#   task :x86_64 => :environment do
#     require 'rpm'
#     puts "#{Time.now.to_s}: import *.x86_64.rpm from Platform6 to database"
#     Package.import_packages_x86_64('ALT Linux', 'Platform6', '/ALT/p6/files/x86_64/RPMS/*.x86_64.rpm')
#     puts "#{Time.now.to_s}: end"
#   end
# end
