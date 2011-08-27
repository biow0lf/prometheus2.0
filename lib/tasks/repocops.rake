namespace :sisyphus do
  desc "Import repocop reports to database"
  task :repocops => :environment do
    puts Time.now.to_s + ": import repocop reports"
    Repocop.update_repocop
    Repocop.update_repocop_cache
    puts Time.now.to_s + ": end"
  end

  desc "Update repocop status cache"
  task :update_repocop_cache => :environment do
    puts Time.now.to_s + ': update repocop cache'
    Repocop.update_repocop_cache
    puts Time.now.to_s + ': end'
  end

  desc "Import repocop patches list to database"
  task :repocop_patches => :environment do
    require 'open-uri'
    puts Time.now.to_s + ': import repocop patches'
    RepocopPatch.update_repocop_patches
    puts Time.now.to_s + ': end'
  end
end
