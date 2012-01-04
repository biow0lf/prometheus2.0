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
    puts "#{Time.now.to_s}: update *.i586.rpm/*.noarch.rpm/*.x86_64.rpm from Platform5 to database"
    pathes = ['/ALT/p5/files/i586/RPMS/*.i586.rpm',
              '/ALT/p5/files/noarch/RPMS/*.noarch.rpm',
              '/ALT/p5/files/x86_64/RPMS/*.x86_64.rpm']
    Package.import_all(branch, pathes)
    puts "#{Time.now.to_s}: end"
    # TODO: review and cleanup this code
    puts "#{Time.now.to_s}: expire cache"
    ['en', 'ru', 'uk', 'br'].each do |locale|
      ActionController::Base.new.expire_fragment("#{locale}_srpms_#{branch.name}_")
      pages_counter = (branch.srpms.where("srpms.created_at > '2010-11-09 09:00:00'").count / 50) + 1
      for page in 1..pages_counter do
        ActionController::Base.new.expire_fragment("#{locale}_srpms_#{branch.name}_#{page}")
      end
    end
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

  desc 'Import *.i586.rpm/*.noarch.rpm/*.x86_64.rpm from Platform5 to database'
  task :binary => :environment do
    require 'open-uri'
    puts "#{Time.now.to_s}: import *.i586.rpm/*.noarch.rpm/*.x86_64.rpm from Platform5 to database"
    branch = Branch.where(name: 'Platform5', vendor: 'ALT Linux').first
    pathes = ['/ALT/p5/files/i586/RPMS/*.i586.rpm',
              '/ALT/p5/files/noarch/RPMS/*.noarch.rpm',
              '/ALT/p5/files/x86_64/RPMS/*.x86_64.rpm']
    Package.import_all(branch, pathes)
    puts "#{Time.now.to_s}: end"
  end

# # TODO: remove this
# #  desc "Import all teams from Platform5 to database"
# #  task :teams => :environment do
# #    require 'open-uri'
# #    puts Time.now.to_s + ": import teams"
# #    Team.import_teams 'ALT Linux', 'Platform5', 'http://git.altlinux.org/acl/list.groups.p5'
# #    puts Time.now.to_s + ": end"
# #  end
end
