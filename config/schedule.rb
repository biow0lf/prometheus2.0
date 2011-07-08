every 1.hour, :at => 5 do
  rake "sisyphus:update sisyphusarm:update platform6:update t6:update platform5:update 51:update 50:update 41:update 40:update gear:update ts:reindex"
end

every 1.day, :at => '5:00 am' do
  rake "sisyphus:bugs"
end

every 1.day, :at => '6:15 am' do
  rake "sisyphus:repocops sisyphus:repocop_patches"
end

every 1.day, :at => '01:00 pm' do
  rake "ftbfs:i586"
end

every :sunday, :at => '3:30 am' do
  rake "sitemap:refresh"
end

# Learn more: http://github.com/javan/whenever
