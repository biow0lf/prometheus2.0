namespace :gear do
  desc 'Import all git repos to database'
  task :import => :environment do
    require 'open-uri'

    Rails.logger.info("#{Time.now.to_s}: import gitrepos")
    if $redis.get('__SYNC__')
      exist = begin
                Process::kill(0, $redis.get('__SYNC__').to_i)
                true
              rescue
                false
              end
      if exist
        Rails.logger.info("#{Time.now.to_s}: update is locked by another cron script")
        Process.exit!(true)
      else
        Rails.logger.info("#{Time.now.to_s}: dead lock found and deleted")
        $redis.del('__SYNC__')
      end
    end
    $redis.set('__SYNC__', Process.pid)
    Gear.import_gitrepos('http://git.altlinux.org/people-packages-list')
    Rails.logger.info("#{Time.now.to_s}: end")
    $redis.del('__SYNC__')
  end

  desc 'Update all git repos to database'
  task :update => :environment do
    require 'open-uri'

    Rails.logger.info("#{Time.now.to_s}: update gitrepos")
    if $redis.get('__SYNC__')
      exist = begin
                Process::kill(0, $redis.get('__SYNC__'))
                true
              rescue
                false
              end
      if exist
        Rails.logger.info("#{Time.now.to_s}: update is locked by another cron script")
        Process.exit!(true)
      else
        Rails.logger.info("#{Time.now.to_s}: dead lock found and deleted")
        $redis.del('__SYNC__')
      end
    end
    $redis.set('__SYNC__', Process.pid)
    Gear.update_gitrepos('http://git.altlinux.org/people-packages-list')
    Rails.logger.info("#{Time.now.to_s}: end")
    $redis.del('__SYNC__')
  end
end
