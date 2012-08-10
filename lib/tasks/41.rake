# encoding: utf-8

namespace :"41" do
  desc 'Update 4.1 stuff'
  task :update => :environment do
    require 'open-uri'
    puts "#{Time.now.to_s}: Update 4.1 stuff"
    if $redis.get('__SYNC__')
      exist = begin
                Process::kill(0, $redis.get('__SYNC__').to_i)
                true
              rescue
                false
              end
      if exist
        puts "#{Time.now.to_s}: update is locked by another cron script"
        Process.exit!(true)
      else
        puts "#{Time.now.to_s}: dead lock found and deleted"
        $redis.del('__SYNC__')
      end
    end
    $redis.set('__SYNC__', Process.pid)
    puts "#{Time.now.to_s}: update *.src.rpm from 4.1 to database"
    branch = Branch.where(name: '4.1', vendor: 'ALT Linux').first
    Srpm.import_all(branch, '/ALT/4.1/files/SRPMS/*.src.rpm')
    Srpm.remove_old(branch, '/ALT/4.1/files/SRPMS/')
    puts "#{Time.now.to_s}: end"
    puts "#{Time.now.to_s}: update *.i586.rpm/*.noarch.rpm/*.x86_64.rpm from 4.1 to database"
    pathes = ['/ALT/4.1/files/i586/RPMS/*.i586.rpm',
              '/ALT/4.1/files/noarch/RPMS/*.noarch.rpm',
              '/ALT/4.1/files/x86_64/RPMS/*.x86_64.rpm']
    Package.import_all(branch, pathes)
    puts "#{Time.now.to_s}: end"
    # TODO: review and cleanup this code
    puts "#{Time.now.to_s}: expire cache"
    ['en', 'ru', 'uk', 'br'].each do |locale|
      ActionController::Base.new.expire_fragment("#{locale}_top15_#{branch.name}")
      ActionController::Base.new.expire_fragment("#{locale}_srpms_#{branch.name}_")
      pages_counter = (branch.srpms.where("srpms.created_at > '2010-11-09 09:00:00'").count / 50) + 1
      for page in 1..pages_counter do
        ActionController::Base.new.expire_fragment("#{locale}_srpms_#{branch.name}_#{page}")
      end
    end
    puts "#{Time.now.to_s}: end"
    puts "#{Time.now.to_s}: update acls in redis cache"
    Acl.update_redis_cache('ALT Linux', '4.1', 'http://git.altlinux.org/acl/list.packages.4.1')
    puts "#{Time.now.to_s}: end"
    puts "#{Time.now.to_s}: update time"
    $redis.set("#{branch.name}:updated_at", Time.now.to_s)
    puts "#{Time.now.to_s}: end"
    $redis.del('__SYNC__')
  end

#   desc "Import all ACL for packages from 4.1 to database (leaders)"
#   task :leaders => :environment do
#     require 'open-uri'
#     puts "#{Time.now.to_s}: import leaders"
#     Leader.import_leaders('ALT Linux', '4.1', 'http://git.altlinux.org/acl/list.packages.4.1')
#     puts "#{Time.now.to_s}: end"
#   end
# 
#   desc "Import all teams from 4.1 to database"
#   task :teams => :environment do
#     require 'open-uri'
#     puts "#{Time.now.to_s}: import teams"
#     Team.import_teams('ALT Linux', '4.1', 'http://git.altlinux.org/acl/list.groups.4.1')
#     puts "#{Time.now.to_s}: end"
#   end
end
