namespace :perlwatch do
  desc 'Import CPAN info to database'
  task :update => :environment do
    puts "#{Time.now.to_s}: import CPAN info to database"
    PerlWatch.import_data('http://www.cpan.org/modules/02packages.details.txt.gz')
    puts "#{Time.now.to_s}: end"
  end
end
