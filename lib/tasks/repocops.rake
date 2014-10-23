namespace :sisyphus do
  desc 'Import repocop reports to database'
  task :repocops => :environment do
    Rails.logger.info "#{ Time.now }: import repocop reports"
    if $redis.get('__SYNC__')
      exist = begin
                Process::kill(0, $redis.get('__SYNC__').to_i)
                true
              rescue
                false
              end
      if exist
        Rails.logger.info "#{ Time.now }: update is locked by another cron script"
        Process.exit!(true)
      else
        Rails.logger.info "#{ Time.now }: dead lock found and deleted"
        $redis.del('__SYNC__')
      end
    end
    $redis.set('__SYNC__', Process.pid)
    Repocop.update_repocop
    Repocop.update_repocop_cache
    Rails.logger.info "#{ Time.now }: end"
    $redis.del('__SYNC__')
  end

  desc 'Update repocop status cache'
  task :update_repocop_cache => :environment do
    Rails.logger.info "#{ Time.now }: update repocop cache"
    if $redis.get('__SYNC__')
      exist = begin
                Process::kill(0, $redis.get('__SYNC__').to_i)
                true
              rescue
                false
              end
      if exist
        Rails.logger.info "#{ Time.now }: update is locked by another cron script"
        Process.exit!(true)
      else
        Rails.logger.info "#{ Time.now }: dead lock found and deleted"
        $redis.del('__SYNC__')
      end
    end
    $redis.set('__SYNC__', Process.pid)
    Repocop.update_repocop_cache
    Rails.logger.info "#{ Time.now }: end"
    $redis.del('__SYNC__')
  end

  desc 'Import repocop patches list to database'
  task :repocop_patches => :environment do
    Rails.logger.info "#{ Time.now }: import repocop patches"
    if $redis.get('__SYNC__')
      exist = begin
                Process::kill(0, $redis.get('__SYNC__').to_i)
                true
              rescue
                false
              end
      if exist
        Rails.logger.info "#{ Time.now }: update is locked by another cron script"
        Process.exit!(true)
      else
        Rails.logger.info "#{ Time.now }: dead lock found and deleted"
        $redis.del('__SYNC__')
      end
    end
    $redis.set('__SYNC__', Process.pid)
    RepocopPatch.update_repocop_patches
    Rails.logger.info "#{Time.now.to_s}: end"
    $redis.del('__SYNC__')
  end
end
