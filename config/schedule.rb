# encoding: utf-8

job_type :rake, "cd /home/prometheusapp/current && RAILS_ENV=:environment bundle exec rake :task :output"

every 1.hour, :at => 5 do
  rake 'sisyphus:update platform6:update t6:update platform5:update 51:update 50:update gear:update ts:reindex'
end

# every 1.hour, :at => 5 do
#   rake '41:update 40:update gear:update ts:reindex'
# end

every 1.day, :at => '05:30' do
  rake 'sisyphusarm:update ts:reindex'
end

every 1.day, :at => '05:00' do
  rake 'sisyphus:bugs'
end

every 1.day, :at => '06:15' do
  rake 'sisyphus:repocops sisyphus:repocop_patches'
end

# every 1.day, :at => '13:00' do
#   rake 'ftbfs:update'
# end

every :sunday, :at => '03:30' do
  rake 'sitemap:clean sitemap:refresh'
end

every :sunday, :at => '06:30' do
  rake 'perlwatch:update'
end

# Learn more: http://github.com/javan/whenever
