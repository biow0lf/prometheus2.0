namespace :t6 do
  desc 'Update t6 stuff'
  task :update => :environment do
    require 'open-uri'
    puts "#{Time.now}: Update t6 stuff"
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
    puts "#{Time.now}: update *.src.rpm from t6 to database"
    branch = Branch.where(name: 't6', vendor: 'ALT Linux').first
    ThinkingSphinx::Deltas.suspend! if ENV['PROMETHEUS2_BOOTSTRAP'] == 'yes'
    Srpm.import_all(branch, '/ALT/t6/files/SRPMS/*.src.rpm')
    Srpm.remove_old(branch, '/ALT/t6/files/SRPMS/')
    puts "#{Time.now}: end"
    puts "#{Time.now}: update *.i586.rpm/*.noarch.rpm/*.x86_64.rpm from t6 to database"
    pathes = ['/ALT/t6/files/i586/RPMS/*.i586.rpm',
              '/ALT/t6/files/noarch/RPMS/*.noarch.rpm',
              '/ALT/t6/files/x86_64/RPMS/*.x86_64.rpm']
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
    Acl.update_redis_cache(branch, 'http://git.altlinux.org/acl/list.packages.t6')
    puts "#{Time.now}: end"
    puts "#{Time.now}: update leaders in redis cache"
    Leader.update_redis_cache('ALT Linux', 't6', 'http://git.altlinux.org/acl/list.packages.t6')
    puts "#{Time.now}: end"
    puts "#{Time.now}: update time"
    Redis.current.set("#{branch.name}:updated_at", Time.now.to_s)
    puts "#{Time.now}: end"
    Redis.current.del('__SYNC__')
  end
end
