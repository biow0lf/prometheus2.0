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
  task branches: %i(environment lock) do
    puts "#{ Time.zone.now }: Update branch stuffes"
    Redis.current.set('__SYNC__', Process.pid)

    Branch.all.each do |branch|
      puts "#{ Time.zone.now }: import all src rpms from #{branch.name} branch to database"
      Package::Src.import_all(branch)

      puts "#{ Time.zone.now }: import all built rpms from #{branch.name} branch to database"
      Package::Built.import_all(branch)
    end

    Redis.current.del('__SYNC__')
  end

  desc 'Update redis'
  task redis: %i(environment lock) do
    puts "#{ Time.zone.now }: Update branch stuffes"
    Redis.current.set('__SYNC__', Process.pid)

    Branch.all.each do |branch|
      puts "#{ Time.zone.now }: update acls in redis cache"
      Acl.update_redis_cache(branch, "http://git.altlinux.org/acl/list.packages.#{branch.acl_name}")

      puts "#{ Time.zone.now }: update leaders in redis cache"
      Leader.update_redis_cache(branch, "http://git.altlinux.org/acl/list.packages.#{branch.acl_name}")
    end

    Redis.current.del('__SYNC__')
  end

  desc 'Remove lost srpms'
  task :lost, %i(remove) => %i(environment lock) do |t, args|
    remove = args[:remove] == "true"

    puts "#{ Time.zone.now }: Update branch stuffes"
    Redis.current.set('__SYNC__', Process.pid)

    Branch.all.each do |branch|
      puts "#{ Time.zone.now }: remove lost *.src.rpm from #{branch.name} branch"

      branch.branch_paths.src.active.each do |branch_path|
        if remove
          RemoveOldSrpms.call(branch_path) do
            on(:ok) { puts "#{ Time.zone.now }: Old srpms removed" }
          end
        else
          count = RemoveOldSrpms.new(branch_path).count

          puts "#{count} source packages are to remove for #{branch_path.name}"
        end
      end
    end
  end

  desc 'Drop imported at counter for specific branch'
  task :drop_counter, %i(branch_path) => %i(environment) do |t, args|
    puts "#{ Time.zone.now }: Drop updated counter for #{args[:branch_path]}"

    BranchPath.where(name: args[:branch_path]).update_all(imported_at: Time.at(0))
  end
end
