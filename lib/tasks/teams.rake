require 'open-uri'

namespace :sisyphus do
desc "Import all teams from Sisyphus to database"
task :teams => :environment do
  puts "import teams"
  puts Time.now

  ActiveRecord::Base.transaction do
    branch = Branch.find :first, :conditions => { :urlname => 'Sisyphus' }
    ActiveRecord::Base.connection.execute("DELETE FROM teams WHERE branch_id = " + branch.id.to_s)

    url = branch.acls_groups_url
    file = open(URI.escape(url)).read

    file.each_line do |line|
      team_name  = line.split[0]
      for i in 1..line.split.count-1
        if i == 1
          Team.create(:name => team_name, :login => line.split[i], :leader => true, :branch_id => branch.id )
        else
          Team.create(:name => team_name, :login => line.split[i], :leader => false, :branch_id => branch.id )
        end
      end
    end
  end
  puts Time.now
end
end
