# frozen_string_literal: true

namespace :t7 do
  desc 'Update t7 stuff'
  task update: :environment do
    puts "#{ Time.zone.now }: Update t7 stuff"
    if Redis.current.get('__SYNC__')
      exist = begin
                Process.kill(0, Redis.current.get('__SYNC__').to_i)
                true
              rescue
                false
              end
      if exist
        puts "#{ Time.zone.now }: update is locked by another cron script"
        Process.exit!(true)
      else
        puts "#{ Time.zone.now }: dead lock found and deleted"
        Redis.current.del('__SYNC__')
      end
    end
    Redis.current.set('__SYNC__', Process.pid)
    puts "#{ Time.zone.now }: update *.src.rpm from t7 to database"
    branch = Branch.find_by!(name: 't7')
    Srpm.import_all(branch, '/ALT/t7/files/SRPMS/*.src.rpm')
    RemoveOldSrpms.call(branch, '/ALT/t7/files/SRPMS/') do
      on(:ok) { puts "#{ Time.zone.now }: Old srpms removed" }
    end
    puts "#{ Time.zone.now }: update *.i586.rpm/*.noarch.rpm/*.x86_64.rpm from t7 to database"
    pathes = ['/ALT/t7/files/i586/RPMS/*.i586.rpm',
              '/ALT/t7/files/noarch/RPMS/*.noarch.rpm',
              '/ALT/t7/files/x86_64/RPMS/*.x86_64.rpm']
    Package.import_all(branch, pathes)
    puts "#{ Time.zone.now }: end"
    puts "#{ Time.zone.now }: update acls in redis cache"
    Acl.update_redis_cache(branch, 'http://git.altlinux.org/acl/list.packages.t7')
    puts "#{ Time.zone.now }: end"
    puts "#{ Time.zone.now }: update leaders in redis cache"
    Leader.update_redis_cache(branch, 'http://git.altlinux.org/acl/list.packages.t7')
    puts "#{ Time.zone.now }: end"
    puts "#{ Time.zone.now }: update time"
    Redis.current.set("#{ branch.name }:updated_at", Time.now.to_s)
    puts "#{ Time.zone.now }: end"
    Redis.current.del('__SYNC__')
  end
end
