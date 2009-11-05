require 'open-uri'

namespace :sisyphus do
namespace :update do
desc "Import RPM groups for Sisyphus to database"
task :groups => :environment do
  puts "update groups"
  puts Time.now

  ActiveRecord::Base.transaction do
    branch = Branch.find :first, :conditions => { :urlname => 'Sisyphus' }
    url = "http://git.altlinux.org/gears/r/rpm.git?p=rpm.git;a=blob_plain;f=GROUPS"
    file = open(URI.escape(url)).read

    file.each_line do |line|
      group = Group.find :first, :conditions => { :name => line.gsub(/\n/,''), :branch_id => branch.id }
      if group == nil
        Group.create :name => line.gsub(/\n/,''), :branch_id => branch.id
      end
    end
  end
  puts Time.now
end
end
end
