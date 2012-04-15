# encoding: utf-8

namespace :perlwatch do
  desc 'Import CPAN info to database'
  task :update => :environment do
    puts "#{Time.now.to_s}: import CPAN info to database"
    if $redis.get('__SYNC__')
      puts "#{Time.now.to_s}: update is locked by another cron script"
      Process.exit!(true)
    end
    $redis.set('__SYNC__', 1)
    PerlWatch.import_data('http://www.cpan.org/modules/02packages.details.txt.gz')
    puts "#{Time.now.to_s}: end"
    $redis.del('__SYNC__')
  end
end
