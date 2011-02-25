namespace :gitrepos do
  desc "Import all git repos to database"
  task :import => :environment do
    require 'open-uri'

    puts "#{Time.now.to_s}: import gitrepos"
    Gitrepo.import_gitrepos('http://git.altlinux.org/people-packages-list')
    puts "#{Time.now.to_s}: end"
  end

  desc "Update all git repos to database"
  task :update => :environment do
    require 'open-uri'

    ActiveRecord::Base.transaction do
      puts "#{Time.now.to_s}: update gitrepos"
      Gitrepo.import_gitrepos('http://git.altlinux.org/people-packages-list')
      puts "#{Time.now.to_s}: end"
    end
  end
end
