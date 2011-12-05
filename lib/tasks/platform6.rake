# encoding: utf-8

namespace :platform6 do
  desc 'Update Platform6 stuff'
  task :update => :environment do
    require 'open-uri'
    puts "#{Time.now.to_s}: Update Platform6 stuff"
    puts "#{Time.now.to_s}: update *.src.rpm from Platform6 to database"
    branch = Branch.where(name: 'Platform6', vendor: 'ALT Linux').first
    Srpm.import_all(branch, '/ALT/p6/files/SRPMS/*.src.rpm')
    Srpm.remove_old(branch, '/ALT/p6/files/SRPMS/')
    puts "#{Time.now.to_s}: end"
  end

  desc 'Import *.src.rpm from Platform6 to database'
  task :srpms => :environment do
    require 'open-uri'
    puts "#{Time.now.to_s}: import *.src.rpm from Platform6 to database"
    branch = Branch.where(name: 'Platform6', vendor: 'ALT Linux').first
    Srpm.import_all(branch, '/ALT/p6/files/SRPMS/*.src.rpm')
    puts "#{Time.now.to_s}: end"
  end

# TODO:
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
end
