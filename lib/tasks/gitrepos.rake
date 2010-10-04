namespace :sisyphus do
  desc "Import all git repos to database"
  task :gitrepos => :environment do
    require 'open-uri'
    puts Time.now.to_s + ": import gitrepos"
    Gitrepo.import_gitrepos 'http://git.altlinux.org/people-packages-list'
    puts Time.now.to_s + ": end"
  end
end