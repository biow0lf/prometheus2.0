# encoding: utf-8

namespace :platform5 do
  desc 'Update Platform5 stuff'
  task :update => :environment do
    require 'open-uri'
    puts "#{Time.now.to_s}: Update Platform5 stuff"
    puts "#{Time.now.to_s}: update *.src.rpm from Platform5 to database"
    branch = Branch.where(name: 'Platform5', vendor: 'ALT Linux').first
    Srpm.import_all(branch, '/ALT/p5/files/SRPMS/*.src.rpm')
    Srpm.remove_old(branch, '/ALT/p5/files/SRPMS/')
    puts "#{Time.now.to_s}: end"
  end

  desc 'Import *.src.rpm from Platform5 to database'
  task :srpms => :environment do
    require 'open-uri'
    puts "#{Time.now.to_s}: import *.src.rpm from Platform5 to database"
    branch = Branch.where(name: 'Platform5', vendor: 'ALT Linux').first
    Srpm.import_all(branch, '/ALT/p5/files/SRPMS/*.src.rpm')
    puts "#{Time.now.to_s}: end"
  end

# TODO:
#   desc 'Import *.i586.rpm from Platform5 to database'
#   task :i586 => :environment do
#     require 'rpm'
#     puts "#{Time.now.to_s}: import *.i586.rpm from Platform5 to database"
#     Package.import_packages_i586('ALT Linux', 'Platform5', '/ALT/p5/files/i586/RPMS/*.i586.rpm')
#     puts "#{Time.now.to_s}: end"
#   end
# 
#   desc 'Import *.noarch.rpm from Platform5 to database'
#   task :noarch => :environment do
#     require 'rpm'
#     puts "#{Time.now.to_s}: import *.noarch.rpm from Platform5 to database"
#     Package.import_packages_noarch('ALT Linux', 'Platform5', '/ALT/p5/files/noarch/RPMS/*.noarch.rpm')
#     puts "#{Time.now.to_s}: end"
#   end
# 
#   desc 'Import *.x86_64.rpm from Platform5 to database'
#   task :x86_64 => :environment do
#     require 'rpm'
#     puts "#{Time.now.to_s}: import *.x86_64.rpm from Platform5 to database"
#     Package.import_packages_x86_64('ALT Linux', 'Platform5', '/ALT/p5/files/x86_64/RPMS/*.x86_64.rpm')
#     puts "#{Time.now.to_s}: end"
#   end
# 
# # TODO: remove this
# #  desc "Import all teams from Platform5 to database"
# #  task :teams => :environment do
# #    require 'open-uri'
# #    puts Time.now.to_s + ": import teams"
# #    Team.import_teams 'ALT Linux', 'Platform5', 'http://git.altlinux.org/acl/list.groups.p5'
# #    puts Time.now.to_s + ": end"
# #  end
end
