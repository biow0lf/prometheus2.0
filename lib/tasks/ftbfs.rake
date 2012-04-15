# encoding: utf-8

namespace :ftbfs do
  desc 'Import list of ftbfs packages on i586 and x86_64 to database'
  task :update => :environment do
    require 'open-uri'

    puts "#{Time.now.to_s}: import ftbfs list for i586 and x86_64"
    if $redis.get('__SYNC__')
      puts "#{Time.now.to_s}: update is locked by another cron script"
      Process.exit!(true)
    end
    $redis.set('__SYNC__', 1)
    Ftbfs.transaction do
      Ftbfs.delete_all

      Ftbfs.update_ftbfs('ALT Linux', 'Sisyphus', 'http://git.altlinux.org/beehive/stats/Sisyphus-i586/ftbfs-joined', 'i586')
      Ftbfs.update_ftbfs('ALT Linux', 'Sisyphus', 'http://git.altlinux.org/beehive/stats/Sisyphus-x86_64/ftbfs-joined', 'x86_64')

      Ftbfs.update_ftbfs('ALT Linux', 'Platform6', 'http://git.altlinux.org/beehive/stats/p6-i586/ftbfs-joined', 'i586')
      Ftbfs.update_ftbfs('ALT Linux', 'Platform6', 'http://git.altlinux.org/beehive/stats/p6-x86_64/ftbfs-joined', 'x86_64')

      Ftbfs.update_ftbfs('ALT Linux', 't6', 'http://git.altlinux.org/beehive/stats/t6-i586/ftbfs-joined', 'i586')
      Ftbfs.update_ftbfs('ALT Linux', 't6', 'http://git.altlinux.org/beehive/stats/t6-x86_64/ftbfs-joined', 'x86_64')
    end
    puts "#{Time.now.to_s}: end"
    $redis.del('__SYNC__')
  end
end
