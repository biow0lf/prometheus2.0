namespace :platform5 do
namespace :update do
desc "Update *.src.rpm from Platform5 to database"
task :srpms => :environment do
  require 'rpm'
  puts Time.now.to_s + "import src.rpm's"
  ActiveRecord::Base.transaction do
    ActiveRecord::Base.connection.execute("DELETE FROM srpms WHERE branch = 'Platform5' AND vendor = 'ALT Linux'")
    Srpm.import_srpms 'ALT Linux', 'Platform5'
  end
  puts Time.now.to_s + ": end"
end

desc "Update *.i586.rpm from Platform5 to database"
task :i586 => :environment do
  require 'rpm'
  puts Time.now.to_s + ": import i586.rpm's"
  ActiveRecord::Base.transaction do
    ActiveRecord::Base.connection.execute("DELETE FROM packages WHERE arch = 'i586' AND branch = 'Platform5' AND vendor = 'ALT Linux'")
    Package.import_packages_i586 'ALT Linux', 'Platform5'
  end
  puts Time.now.to_s + ": end"
end

desc "Update *.noarch.rpm from Platform5 to database"
task :noarch => :environment do
  require 'rpm'
  puts Time.now.to_s + "import noarch.rpm's"
  ActiveRecord::Base.transaction do
    ActiveRecord::Base.connection.execute("DELETE FROM packages WHERE arch = 'noarch' AND branch = 'Platform5' AND vendor = 'ALT Linux'")
    Package.import_packages_noarch 'ALT Linux', 'Platform5'
  end
  puts Time.now.to_s + ": end"
end

desc "Update *.x86_64.rpm from Platform5 to database"
task :x86_64 => :environment do
  require 'rpm'
  puts Time.now.to_s + "import x86_64.rpm's"
  ActiveRecord::Base.transaction do
    ActiveRecord::Base.connection.execute("DELETE FROM packages WHERE arch = 'x86_64' AND branch = 'Platform5' AND vendor = 'ALT Linux'")
    Package.import_packages_x86_64 'ALT Linux', 'Platform5'
  end
  puts Time.now.to_s + ": end"
end
end
end
