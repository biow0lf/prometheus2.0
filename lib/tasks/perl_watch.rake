# frozen_string_literal: true

namespace :perlwatch do
  desc 'Import CPAN info to database'
  task update: :environment do
    puts "#{ Time.zone.now }: import CPAN info to database"
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
    PerlWatch.import_data('http://www.cpan.org/modules/02packages.details.txt.gz')
    puts "#{ Time.zone.now }: end"
    Redis.current.del('__SYNC__')
  end
end
