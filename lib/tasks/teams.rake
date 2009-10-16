require 'open-uri'

namespace :sisyphus do
desc "Import all teams from Sisyphus to database"
task :teams => :environment do
  puts "import teams"
  puts Time.now

  Team.transaction do
    Team.delete_all

    url = "http://git.altlinux.org/acl/list.groups.sisyphus"
    f = open(URI.escape(url)).read

    f.each_line do |line|
      team_name  = line.split[0]
      #(1..line.split.count).each do |i|
      for i in 1..line.split.count-1
        if i == 1
          Team.create(:name => team_name, :login => line.split[i], :leader => true, :branch => 'Sisyphus')
        else
          Team.create(:name => team_name, :login => line.split[i], :leader => false, :branch => 'Sisyphus')
        end
      end
    end
  end
  puts Time.now
end
end
