# frozen_string_literal: true

namespace :update do
  desc 'Lock the env'
  task lock: :environment do
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
  end

  desc 'Update all the branches'
  task branches: [:environment, :lock] do
    puts "#{ Time.zone.now }: Update branch stuffes"
    Redis.current.set('__SYNC__', Process.pid)

    Branch.all.each do |branch|
      puts "#{ Time.zone.now }: update *.src.rpm from #{branch.name} branch to database"

      Srpm.import_all(branch)

      branch.branch_paths.source.each do |branch_path|
        RemoveOldSrpms.call(branch_path) do
          on(:ok) { puts "#{ Time.zone.now }: Old srpms removed" }
        end
      end

      puts "#{ Time.zone.now }: update *.arch.rpm from #{branch.name} branch to database"
      Package.import_all(branch)
      puts "#{ Time.zone.now }: end"

      puts "#{ Time.zone.now }: update acls in redis cache"
      Acl.update_redis_cache(branch, "http://git.altlinux.org/acl/list.packages.#{branch.acl_name}")
      puts "#{ Time.zone.now }: end"

      puts "#{ Time.zone.now }: update leaders in redis cache"
      Leader.update_redis_cache(branch, "http://git.altlinux.org/acl/list.packages.#{branch.acl_name}")
      puts "#{ Time.zone.now }: end"

      puts "#{ Time.zone.now }: update time"
      Redis.current.set("#{ branch.name }:updated_at", Time.now.to_s)
      puts "#{ Time.zone.now }: end"
    end

    Redis.current.del('__SYNC__')
  end
end
