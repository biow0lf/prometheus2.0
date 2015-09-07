namespace :sisyphus do
  desc 'Import repocop reports to database'
  task repocops: :environment do
    puts "#{ Time.now }: import repocop reports"
    if Redis.current.get('__SYNC__')
      exist = begin
                Process.kill(0, Redis.current.get('__SYNC__').to_i)
                true
              rescue
                false
              end
      if exist
        puts "#{ Time.now }: update is locked by another cron script"
        Process.exit!(true)
      else
        puts "#{ Time.now }: dead lock found and deleted"
        Redis.current.del('__SYNC__')
      end
    end
    Redis.current.set('__SYNC__', Process.pid)
    Repocop.update_repocop
    Repocop.update_repocop_cache
    puts "#{ Time.now }: end"
    Redis.current.del('__SYNC__')
  end

  desc 'Update repocop status cache'
  task update_repocop_cache: :environment do
    puts "#{ Time.now }: update repocop cache"
    if Redis.current.get('__SYNC__')
      exist = begin
                Process.kill(0, Redis.current.get('__SYNC__').to_i)
                true
              rescue
                false
              end
      if exist
        puts "#{ Time.now }: update is locked by another cron script"
        Process.exit!(true)
      else
        puts "#{ Time.now }: dead lock found and deleted"
        Redis.current.del('__SYNC__')
      end
    end
    Redis.current.set('__SYNC__', Process.pid)
    Repocop.update_repocop_cache
    puts "#{ Time.now }: end"
    Redis.current.del('__SYNC__')
  end

  desc 'Import repocop patches list to database'
  task repocop_patches: :environment do
    puts "#{ Time.now }: import repocop patches"
    if Redis.current.get('__SYNC__')
      exist = begin
                Process.kill(0, Redis.current.get('__SYNC__').to_i)
                true
              rescue
                false
              end
      if exist
        puts "#{ Time.now }: update is locked by another cron script"
        Process.exit!(true)
      else
        puts "#{ Time.now }: dead lock found and deleted"
        Redis.current.del('__SYNC__')
      end
    end
    Redis.current.set('__SYNC__', Process.pid)
    RepocopPatch.update_repocop_patches
    puts "#{ Time.now }: end"
    Redis.current.del('__SYNC__')
  end
end
