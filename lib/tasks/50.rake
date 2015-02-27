namespace :"50" do
  desc 'Update 5.0 stuff'
  task :update => :environment do
    puts "#{Time.now}: Update 5.0 stuff"
    if Redis.current.get('__SYNC__')
      exist = begin
                Process::kill(0, Redis.current.get('__SYNC__').to_i)
                true
              rescue
                false
              end
      if exist
        puts "#{Time.now}: update is locked by another cron script"
        Process.exit!(true)
      else
        puts "#{Time.now}: dead lock found and deleted"
        Redis.current.del('__SYNC__')
      end
    end
    Redis.current.set('__SYNC__', Process.pid)
    puts "#{Time.now}: update *.src.rpm from 5.0 to database"
    branch = Branch.where(name: '5.0', vendor: 'ALT Linux').first
    ThinkingSphinx::Deltas.suspend! if ENV['PROMETHEUS2_BOOTSTRAP'] == 'yes'
    Srpm.import_all(branch, '/ALT/5.0/files/SRPMS/*.src.rpm')
    Srpm.remove_old(branch, '/ALT/5.0/files/SRPMS/')
    puts "#{Time.now}: end"
    puts "#{Time.now}: update *.i586.rpm/*.noarch.rpm/*.x86_64.rpm from 5.0 to database"
    pathes = ['/ALT/5.0/files/i586/RPMS/*.i586.rpm',
              '/ALT/5.0/files/noarch/RPMS/*.noarch.rpm',
              '/ALT/5.0/files/x86_64/RPMS/*.x86_64.rpm']
    Package.import_all(branch, pathes)
    ThinkingSphinx::Deltas.resume! if ENV['PROMETHEUS2_BOOTSTRAP'] == 'yes'
    puts "#{Time.now}: end"
#    # TODO: review and cleanup this code
#    puts "#{Time.now}: expire cache"
#    ['en', 'ru', 'uk', 'br'].each do |locale|
#      ActionController::Base.new.expire_fragment("#{locale}_top15_#{branch.name}")
#      ActionController::Base.new.expire_fragment("#{locale}_srpms_#{branch.name}_")
#      pages_counter = (branch.srpms.where("srpms.created_at > '2010-11-09 09:00:00'").count / 50) + 1
#      for page in 1..pages_counter do
#        ActionController::Base.new.expire_fragment("#{locale}_srpms_#{branch.name}_#{page}")
#      end
#    end
#    puts "#{Time.now}: end"
    puts "#{Time.now}: update acls in redis cache"
    Acl.update_redis_cache(branch, 'http://git.altlinux.org/acl/list.packages.5.0')
    puts "#{Time.now}: end"
    puts "#{Time.now}: update leaders in redis cache"
    Leader.update_redis_cache(branch, 'http://git.altlinux.org/acl/list.packages.5.0')
    puts "#{Time.now}: end"
    puts "#{Time.now}: update time"
    Redis.current.set("#{branch.name}:updated_at", Time.now.to_s)
    puts "#{Time.now}: end"
    Redis.current.del('__SYNC__')
  end

#   desc "Import all ACL for packages from 5.0 to database (leaders)"
#   task :leaders => :environment do
#     require 'open-uri'
#     puts Time.now + ": import leaders"
#     Leader.import_leaders 'ALT Linux', '5.0', 'http://git.altlinux.org/acl/list.packages.5.0'
#     puts Time.now + ": end"
#   end
#
#   desc "Import all teams from 5.0 to database"
#   task :teams => :environment do
#     require 'open-uri'
#     puts Time.now + ": import teams"
#     Team.import_teams 'ALT Linux', '5.0', 'http://git.altlinux.org/acl/list.groups.5.0'
#     puts Time.now + ": end"
#   end
end
