namespace :p7 do
  desc 'Update p7 stuff'
  task :update => :environment do
    puts "#{Time.now}: Update p7 stuff"
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
    puts "#{Time.now}: update *.src.rpm from p7 to database"
    branch = Branch.where(name: 'p7', vendor: 'ALT Linux').first
    ThinkingSphinx::Deltas.suspend! if ENV['PROMETHEUS2_BOOTSTRAP'] == 'yes'
    Srpm.import_all(branch, '/ALT/p7/files/SRPMS/*.src.rpm')
    Srpm.remove_old(branch, '/ALT/p7/files/SRPMS/')
    puts "#{Time.now}: end"
    puts "#{Time.now}: update *.i586.rpm/*.noarch.rpm/*.x86_64.rpm from p7 to database"
    pathes = ['/ALT/p7/files/i586/RPMS/*.i586.rpm',
              '/ALT/p7/files/noarch/RPMS/*.noarch.rpm',
              '/ALT/p7/files/x86_64/RPMS/*.x86_64.rpm']
    Package.import_all(branch, pathes)
    ThinkingSphinx::Deltas.resume! if ENV['PROMETHEUS2_BOOTSTRAP'] == 'yes'
    puts "#{Time.now}: end"
    puts "#{Time.now}: update acls in redis cache"
    Acl.update_redis_cache(branch, 'http://git.altlinux.org/acl/list.packages.p7')
    puts "#{Time.now}: end"
    puts "#{Time.now}: update leaders in redis cache"
    Leader.update_redis_cache(branch, 'http://git.altlinux.org/acl/list.packages.p7')
    puts "#{Time.now}: end"
    puts "#{Time.now}: update time"
    Redis.current.set("#{branch.name}:updated_at", Time.now.to_s)
    puts "#{Time.now}: end"
    Redis.current.del('__SYNC__')
  end
end
