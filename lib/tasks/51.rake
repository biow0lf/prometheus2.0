# frozen_string_literal: true

namespace :'51' do
  desc 'Update 5.1 stuff'
  task update: :environment do
    puts "#{ Time.zone.now }: Update 5.1 stuff"
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
    puts "#{ Time.zone.now }: update *.src.rpm from 5.1 to database"
    branch = Branch.find_by!(name: '5.1')
    Srpm.import_all(branch, '/ALT/5.1/files/SRPMS/*.src.rpm')
    RemoveOldSrpms.call(branch, '/ALT/5.1/files/SRPMS/') do
      on(:ok) { puts "#{ Time.zone.now }: Old srpms removed" }
    end
    puts "#{ Time.zone.now }: update *.i586.rpm/*.noarch.rpm/*.x86_64.rpm from 5.1 to database"
    pathes = ['/ALT/5.1/files/i586/RPMS/*.i586.rpm',
              '/ALT/5.1/files/noarch/RPMS/*.noarch.rpm',
              '/ALT/5.1/files/x86_64/RPMS/*.x86_64.rpm']
    Package.import_all(branch, pathes)
    puts "#{ Time.zone.now }: end"
    puts "#{ Time.zone.now }: update acls in redis cache"
    Acl.update_redis_cache(branch, 'http://git.altlinux.org/acl/list.packages.5.1')
    puts "#{ Time.zone.now }: end"
    puts "#{ Time.zone.now }: update leaders in redis cache"
    Leader.update_redis_cache(branch, 'http://git.altlinux.org/acl/list.packages.5.1')
    puts "#{ Time.zone.now }: end"
    puts "#{ Time.zone.now }: update time"
    Redis.current.set("#{ branch.name }:updated_at", Time.now.to_s)
    puts "#{ Time.zone.now }: end"
    Redis.current.del('__SYNC__')
  end

#   desc "Import all ACL for packages from 5.1 to database (leaders)"
#   task leaders: :environment do
#     require 'open-uri'
#     puts "#{ Time.now }: import leaders"
#     Leader.import_leaders 'ALT Linux', '5.1', 'http://git.altlinux.org/acl/list.packages.5.1'
#     puts "#{ Time.now }: end"
#   end
#
#   desc "Import all teams from 5.1 to database"
#   task teams: :environment do
#     require 'open-uri'
#     puts "#{ Time.now }: import teams"
#     Team.import_teams 'ALT Linux', '5.1', 'http://git.altlinux.org/acl/list.groups.5.1'
#     puts "#{ Time.now }: end"
#   end
end
