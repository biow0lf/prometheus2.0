require 'open-uri'

namespace :"41" do
desc "Import RPM groups for 4.1 to database"
task :groups => :environment do
  puts "import groups"
  puts Time.now

  ActiveRecord::Base.transaction do
    ActiveRecord::Base.connection.execute("DELETE FROM groups WHERE branch = '4.1'")

    url = "http://git.altlinux.org/gears/r/rpm.git?p=rpm.git;a=blob_plain;f=GROUPS"
    file = open(URI.escape(url)).read

    file.each_line do |line|
      Group.create :name => line.gsub(/\n/,''), :branch => '4.1'
    end
  end
  puts Time.now
end
end
