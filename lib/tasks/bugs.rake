# $KCODE="UTF8"

namespace :sisyphus do
  desc "Import all bugs to database"
  task :bugs => :environment do
    puts "#{Time.now.to_s}: import bugs"
    Bug.import('https://bugzilla.altlinux.org/buglist.cgi?ctype=csv')
    puts "#{Time.now.to_s}: end"
  end
end
