namespace :clear do
  desc 'Clear all cache'
  task cache: :environment do
    puts "#{Time.now}: Clear cache"

    puts "#{Time.now}: end"
  end
end
