namespace :ftbfs do
  desc 'Import list of ftbfs packages on i586 and x86_64 to database'
  task :update => :environment do
    require 'open-uri'

    puts "#{Time.now}: import ftbfs list for i586 and x86_64"
    if Redis.current.get('__SYNC__')
      exist = begin
                Process::kill(0, Redis.current.get('__SYNC__').to_i)
                true
              rescue
                false
              end
      if exist
        puts "#{Time.now}: update is locked by another cron script"
        Process.exit!(true)
      else
        puts "#{Time.now}: dead lock found and deleted"
        Redis.current.del('__SYNC__')
      end
    end
    Redis.current.set('__SYNC__', Process.pid)
    Ftbfs.transaction do
      Ftbfs.delete_all

      Ftbfs.update_ftbfs('ALT Linux', 'Sisyphus', 'http://git.altlinux.org/beehive/stats/Sisyphus-i586/ftbfs-joined', 'i586')
      Ftbfs.update_ftbfs('ALT Linux', 'Sisyphus', 'http://git.altlinux.org/beehive/stats/Sisyphus-x86_64/ftbfs-joined', 'x86_64')

      Ftbfs.update_ftbfs('ALT Linux', 'p7', 'http://git.altlinux.org/beehive/stats/p7-i586/ftbfs-joined', 'i586')
      Ftbfs.update_ftbfs('ALT Linux', 'p7', 'http://git.altlinux.org/beehive/stats/p7-x86_64/ftbfs-joined', 'x86_64')

      Ftbfs.update_ftbfs('ALT Linux', 'Platform6', 'http://git.altlinux.org/beehive/stats/p6-i586/ftbfs-joined', 'i586')
      Ftbfs.update_ftbfs('ALT Linux', 'Platform6', 'http://git.altlinux.org/beehive/stats/p6-x86_64/ftbfs-joined', 'x86_64')

      Ftbfs.update_ftbfs('ALT Linux', 't6', 'http://git.altlinux.org/beehive/stats/t6-i586/ftbfs-joined', 'i586')
      Ftbfs.update_ftbfs('ALT Linux', 't6', 'http://git.altlinux.org/beehive/stats/t6-x86_64/ftbfs-joined', 'x86_64')
    end
    puts "#{Time.now}: end"
    Redis.current.del('__SYNC__')
  end
end
