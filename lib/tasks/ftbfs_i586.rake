namespace :ftbfs do
  desc 'Import list of ftbfs packages on i586 to database'
  task :i586 => :environment do
    require 'open-uri'

    puts "#{Time.now.to_s}: import ftbfs list for i586"
    Ftbfs.update_ftbfs('ALT Linux', 'Sisyphus', 'http://git.altlinux.org/beehive/stats/Sisyphus-i586/ftbfs-joined')
    puts "#{Time.now.to_s}: end"
  end
end
