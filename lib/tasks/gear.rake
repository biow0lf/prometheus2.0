# encoding: utf-8

namespace :gear do
  desc 'Import all git repos to database'
  task :import => :environment do
    require 'open-uri'

    puts "#{Time.now.to_s}: import gitrepos"
    if $redis.get('__SYNC__')
      puts "#{Time.now.to_s}: update is locked by another cron script"
      Process.exit!(true)
    end
    $redis.set('__SYNC__', Process.pid)
    Gear.import_gitrepos('http://git.altlinux.org/people-packages-list')
    puts "#{Time.now.to_s}: end"
    $redis.del('__SYNC__')
  end

  desc 'Update all git repos to database'
  task :update => :environment do
    require 'open-uri'

    puts "#{Time.now.to_s}: update gitrepos"
    if $redis.get('__SYNC__')
      puts "#{Time.now.to_s}: update is locked by another cron script"
      Process.exit!(true)
    end
    $redis.set('__SYNC__', Process.pid)
    Gear.update_gitrepos('http://git.altlinux.org/people-packages-list')
    puts "#{Time.now.to_s}: end"
    $redis.del('__SYNC__')
  end
end
