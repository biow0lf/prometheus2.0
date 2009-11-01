#require 'open-uri'

namespace :sisyphus do
desc "Import RPM groups for Sisyphus to database"
task :groups => :environment do
  puts "import groups"
  puts Time.now

  ActiveRecord::Base.transaction do
#    Group.delete_all

    branch = Branch.find :first, :conditions => { :urlname => 'Sisyphus' }
    #url = "http://git.altlinux.org/people/ldv/packages/?p=rpm.git;a=blob_plain;f=GROUPS;hb=HEAD"
    url = "/usr/lib/rpm/GROUPS"
    file = open(URI.escape(url)).read

    file.each_line do |line|
      Group.create :name => line.gsub(/\n/,''), :branch_id => branch.id
    end
  end
  puts Time.now
end
end
