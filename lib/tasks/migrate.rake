# encoding: utf-8

namespace :migrate do
  desc 'Move Maintainers Team to MaintainerTeam'
  task :maintainers => :environment do
    Maintainer.where(team: true).all.each do |team|
      MaintainerTeam.create!(name: team.name, email: team.email, login: team.login)
    end
    Maintainer.where(team: true).delete_all
  end
end
