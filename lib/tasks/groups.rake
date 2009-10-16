require 'open-uri'

namespace :sisyphus do
desc "Import groups to database"
task :groups => :environment do
  puts "import groups"
  puts Time.now

  Group.transaction do
    Group.delete_all

    url = "http://git.altlinux.org/people/ldv/packages/?p=rpm.git;a=blob_plain;f=GROUPS;hb=HEAD"
    f = open(URI.escape(url)).read

    f.each_line do |line|
      group = Group.create(:name => line.gsub(/\n/,''), :branch => 'Sisyphus')
    end
  end
  puts Time.now
end
end
