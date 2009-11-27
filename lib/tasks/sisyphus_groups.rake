require 'open-uri'

namespace :sisyphus do
desc "Import RPM groups for Sisyphus to database"
task :groups => :environment do
  puts "import groups"
  puts Time.now

  ActiveRecord::Base.transaction do
    ActiveRecord::Base.connection.execute("DELETE FROM groups WHERE branch = 'Sisyphus'")

    url = "http://git.altlinux.org/gears/r/rpm.git?p=rpm.git;a=blob_plain;f=GROUPS"
    file = open(URI.escape(url)).read

    file.each_line do |line|
      Group.create :name => line.gsub(/\n/,''), :branch => 'Sisyphus'
    end
  end
  puts Time.now
end
end
