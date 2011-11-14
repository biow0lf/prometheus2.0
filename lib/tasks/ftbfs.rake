# encoding: utf-8

namespace :ftbfs do
  desc 'Import list of ftbfs packages on i586 and x86_64 to database'
  task :update => :environment do
    require 'open-uri'

    puts "#{Time.now.to_s}: import ftbfs list for i586 and x86_64"
    Ftbfs.transaction do
      Ftbfs.delete_all

      Ftbfs.update_ftbfs('ALT Linux', 'Sisyphus', 'http://git.altlinux.org/beehive/stats/Sisyphus-i586/ftbfs-joined', 'i586')
      Ftbfs.update_ftbfs('ALT Linux', 'Sisyphus', 'http://git.altlinux.org/beehive/stats/Sisyphus-x86_64/ftbfs-joined', 'x86_64')
    end
    puts "#{Time.now.to_s}: end"
  end
end
