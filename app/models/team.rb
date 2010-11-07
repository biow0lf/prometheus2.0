class Team < ActiveRecord::Base
  validates :name, :presence => true
  validates :branch_id, :presence => true
  validates :maintainer_id, :presence => true

  belongs_to :branch
  belongs_to :maintainer

  def self.import_teams(vendor, branch, url)
    b = Branch.where(:name => branch, :vendor => vendor).first
    if b.teams.count(:all) == 0
      file = open(URI.escape(url)).read
      file.each_line do |line|
        team_name  = line.split[0]
        for i in 1..line.split.count-1
          maintainer = Maintainer.where(:login => line.split[i]).first
          if maintainer.nil?
            puts Time.now.to_s + ": maintainer not found '" + line.split[i] + "'"
          else
            if i == 1
              Team.create(:name => team_name, :maintainer_id => maintainer.id, :leader => true, :branch_id => b.id)
            else
              Team.create(:name => team_name, :maintainer_id => maintainer.id, :leader => false, :branch_id => b.id)
            end
          end
        end
      end
    else
      puts Time.now.to_s + ": teams already imported"
    end
  end
end