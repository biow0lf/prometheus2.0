namespace :sisyphus do
  desc 'Import all bugs to database'
  task :bugs => :environment do
    puts "#{ Time.now }: import bugs"
    if $redis.get('__SYNC__')
      exist = begin
                Process::kill(0, $redis.get('__SYNC__').to_i)
                true
              rescue
                false
              end
      if exist
        puts "#{ Time.now }: update is locked by another cron script"
        Process.exit!(true)
      else
        puts "#{ Time.now }: dead lock found and deleted"
        $redis.del('__SYNC__')
      end
    end
    $redis.set('__SYNC__', Process.pid)
    Bug.import('https://bugzilla.altlinux.org/buglist.cgi?ctype=csv')
    puts "#{ Time.now }: end"
    $redis.del('__SYNC__')
  end
end

