every 1.hour, :at => 5 do
  rake "sisyphus:update sisyphusarm:update platform5:update 51:update 50:update 41:update 40:update"
end

every 1.day, :at => '5:00 am' do 
  rake "sisyphus:bugs"
end

every 1.day, :at => '5:15 am' do
  rake "sisyphus:repocops sisyphus:repocop_patches"
end

# Learn more: http://github.com/javan/whenever
