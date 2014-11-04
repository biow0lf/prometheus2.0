namespace :perlwatch do
  desc 'Import CPAN info to database'
  task update: :environment do
    Rails.logger.info "#{ Time.now }: import CPAN info to database"
    if Redis.current.get('__SYNC__')
      exist = begin
                Process.kill(0, Redis.current.get('__SYNC__').to_i)
                true
              rescue
                false
              end
      if exist
        Rails.logger.info "#{ Time.now }: update is locked by another cron script"
        Process.exit!(true)
      else
        Rails.logger.info "#{ Time.now }: dead lock found and deleted"
        Redis.current.del('__SYNC__')
      end
    end
    Redis.current.set('__SYNC__', Process.pid)
    PerlWatch.import_data('http://www.cpan.org/modules/02packages.details.txt.gz')
    Rails.logger.info "#{ Time.now }: end"
    Redis.current.del('__SYNC__')
  end
end
