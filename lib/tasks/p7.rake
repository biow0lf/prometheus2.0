namespace :p7 do
  desc 'Update p7 stuff'
  task :update => :environment do
    require 'open-uri'
    puts "#{Time.now.to_s}: Update p7 stuff"
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
    puts "#{Time.now.to_s}: update *.src.rpm from p7 to database"
    branch = Branch.where(name: 'p7', vendor: 'ALT Linux').first
    ThinkingSphinx::Deltas.suspend! if ENV['PROMETHEUS2_BOOTSTRAP'] == 'yes'
    Srpm.import_all(branch, '/ALT/p7/files/SRPMS/*.src.rpm')
    Srpm.remove_old(branch, '/ALT/p7/files/SRPMS/')
    puts "#{Time.now.to_s}: end"
    puts "#{Time.now.to_s}: update *.i586.rpm/*.noarch.rpm/*.x86_64.rpm from p7 to database"
    pathes = ['/ALT/p7/files/i586/RPMS/*.i586.rpm',
              '/ALT/p7/files/noarch/RPMS/*.noarch.rpm',
              '/ALT/p7/files/x86_64/RPMS/*.x86_64.rpm']
    Package.import_all(branch, pathes)
    ThinkingSphinx::Deltas.resume! if ENV['PROMETHEUS2_BOOTSTRAP'] == 'yes'
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
    Acl.update_redis_cache('ALT Linux', 'p7', 'http://git.altlinux.org/acl/list.packages.p7')
    puts "#{Time.now.to_s}: end"
    puts "#{Time.now.to_s}: update leaders in redis cache"
    Leader.update_redis_cache('ALT Linux', 'p7', 'http://git.altlinux.org/acl/list.packages.p7')
    puts "#{Time.now.to_s}: end"
    puts "#{Time.now.to_s}: update time"
    $redis.set("#{branch.name}:updated_at", Time.now.to_s)
    puts "#{Time.now.to_s}: end"
    $redis.del('__SYNC__')
  end
end
