every 1.hour, :at => 5 do
  rake "sisyphus:update:srpms sisyphus:update:binary sisyphusarm:update:srpms sisyphusarm:update:binary platform5:update:srpms platform5:update:binary 51:update:srpms 51:update:binary 50:update:srpms 50:update:binary 41:update:srpms 41:update:binary 40:update:srpms 40:update:binary"
end

every 1.day, :at => '5:00 am' do 
  rake "sisyphus:bugs"
end

every 1.day, :at => '5:15 am' do
  rake "sisyphus:repocops"
end

# Learn more: http://github.com/javan/whenever
