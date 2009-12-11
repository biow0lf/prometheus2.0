namespace :platform5 do
desc "Import RPM groups for Platform5 to database"
task :groups => :environment do
  require 'open-uri'

  puts "import groups"
  puts Time.now

  ActiveRecord::Base.transaction do
    ActiveRecord::Base.connection.execute("DELETE FROM groups WHERE branch = 'Platform5'")

    url = "http://git.altlinux.org/gears/r/rpm.git?p=rpm.git;a=blob_plain;f=GROUPS"
    file = open(URI.escape(url)).read

    file.each_line do |line|
      Group.create :name => line.gsub(/\n/,''), :branch => 'Platform5'
    end
  end
  puts Time.now
end
end
