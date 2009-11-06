require 'open-uri'

namespace :platform5 do
desc "Import RPM groups for Platform5 to database"
task :groups => :environment do
  puts "import groups"
  puts Time.now

  ActiveRecord::Base.transaction do
#    Group.delete_all

    branch = Branch.find :first, :conditions => { :urlname => 'Platform5' }
    url = "http://git.altlinux.org/gears/r/rpm.git?p=rpm.git;a=blob_plain;f=GROUPS"
    file = open(URI.escape(url)).read

    file.each_line do |line|
      Group.create :name => line.gsub(/\n/,''), :branch_id => branch.id
    end
  end
  puts Time.now
end
end
