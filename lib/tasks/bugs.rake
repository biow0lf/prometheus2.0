# encoding: utf-8

namespace :sisyphus do
  desc 'Import all bugs to database'
  task :bugs => :environment do
    puts "#{Time.now.to_s}: import bugs"
    if $redis.get('__SYNC__')
      puts "#{Time.now.to_s}: update is locked by another cron script"
      Process.exit!(true)
    end
    $redis.set('__SYNC__', 1)
    Bug.import('https://bugzilla.altlinux.org/buglist.cgi?ctype=csv')
    puts "#{Time.now.to_s}: end"
    $redis.del('__SYNC__')
  end
end

