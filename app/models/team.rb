class Team < ActiveRecord::Base
  validates_presence_of :name, :login
  belongs_to :branch

  def self.import_teams(vendor, branch, url)
    br = Branch.first :conditions => { :name => branch, :vendor => vendor }
    if br.teams.count(:all) == 0
      file = open(URI.escape(url)).read
      file.each_line do |line|
        team_name  = line.split[0]
        for i in 1..line.split.count-1
          if i == 1
            Team.create :name => team_name, :login => line.split[i], :leader => true, :branch_id => br.id
          else
            Team.create :name => team_name, :login => line.split[i], :leader => false, :branch_id => br.id
          end
        end
      end
    else
      puts Time.now.to_s + ": teams already imported"
    end
  end

#  def self.update_from_gitalt(vendor, branch, url)
#    ActiveRecord::Base.transaction do
#      ActiveRecord::Base.connection.execute("DELETE FROM teams WHERE branch = '" + branch + "' AND vendor = '" + vendor + "'")
#
#      file = open(URI.escape(url)).read
#      file.each_line do |line|
#        team_name  = line.split[0]
#        for i in 1..line.split.count-1
#          if i == 1
#            Team.create :name => team_name, :login => line.split[i], :leader => true, :branch => branch, :vendor => vendor
#          else
#            Team.create :name => team_name, :login => line.split[i], :leader => false, :branch => branch, :vendor => vendor
#          end
#        end
#      end
#    end
# end
end