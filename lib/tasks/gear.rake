namespace :gear do
  desc 'Import all git repos to database'
  task :import => :environment do
    require 'open-uri'

    puts "#{Time.now.to_s}: import gitrepos"
    Gear.import_gitrepos('http://git.altlinux.org/people-packages-list')
    puts "#{Time.now.to_s}: end"
  end

  desc 'Update all git repos to database'
  task :update => :environment do
    require 'open-uri'

    puts "#{Time.now.to_s}: update gitrepos"
    Gear.update_gitrepos('http://git.altlinux.org/people-packages-list')
    puts "#{Time.now.to_s}: end"
  end
end
