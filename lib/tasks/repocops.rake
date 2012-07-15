# encoding: utf-8

namespace :sisyphus do
  desc 'Import repocop reports to database'
  task :repocops => :environment do
    puts "#{Time.now.to_s}: import repocop reports"
    if $redis.get('__SYNC__')
      exist = begin
                Process::kill(0, $redis.get('__SYNC__'))
                true
              rescue
                false
              end
      if exist
        puts "#{Time.now.to_s}: update is locked by another cron script"
        Process.exit!(true)
      else
        puts "#{Time.now.to_s}: dead lock found and deleted"
        $redis.del('__SYNC__')
      end
    end
    $redis.set('__SYNC__', Process.pid)
    Repocop.update_repocop
    Repocop.update_repocop_cache
    puts "#{Time.now.to_s}: end"
    $redis.del('__SYNC__')
  end

  desc 'Update repocop status cache'
  task :update_repocop_cache => :environment do
    puts "#{Time.now.to_s}: update repocop cache"
    if $redis.get('__SYNC__')
      puts "#{Time.now.to_s}: update is locked by another cron script"
      Process.exit!(true)
    end
    $redis.set('__SYNC__', Process.pid)
    Repocop.update_repocop_cache
    puts "#{Time.now.to_s}: end"
    $redis.del('__SYNC__')
  end

  desc 'Import repocop patches list to database'
  task :repocop_patches => :environment do
    puts "#{Time.now.to_s}: import repocop patches"
    if $redis.get('__SYNC__')
      puts "#{Time.now.to_s}: update is locked by another cron script"
      Process.exit!(true)
    end
    $redis.set('__SYNC__', Process.pid)
    RepocopPatch.update_repocop_patches
    puts "#{Time.now.to_s}: end"
    $redis.del('__SYNC__')
  end
end
