namespace :sisyphus do
  desc 'Import all bugs to database'
  task bugs: :environment do
    Rails.logger.info("#{ Time.zone.now }: import bugs")
    if Redis.current.get('__SYNC__')
      exist = begin
                Process.kill(0, Redis.current.get('__SYNC__').to_i)
                true
              rescue
                false
              end
      if exist
        Rails.logger.info("#{ Time.zone.now }: update is locked by another cron script")
        Process.exit!(true)
      else
        Rails.logger.info("#{ Time.zone.now }: dead lock found and deleted")
        Redis.current.del('__SYNC__')
      end
    end
    Redis.current.set('__SYNC__', Process.pid)
    url = 'https://bugzilla.altlinux.org/buglist.cgi?ctype=csv'
    BugsImport.new(url).execute
    Rails.logger.info("#{ Time.zone.now }: end")
    Redis.current.del('__SYNC__')
  end
end
