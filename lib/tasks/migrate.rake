namespace :migrate do
  desc 'Call Branch.recount! on each branch'
  task recount: :environment do

    Branch.all.each do |branch|
      branch.recount!
    end

    Branch.all.each do |branch|
      Redis.current.del("#{ branch.name }:srpms:counter")
    end
  end

  desc 'Migrate Bugs to new scheme'
  task bugs: :environment do
    Bug.all.each do |bug|
      if bug.resolution == ''
        bug.resolution = nil
        bug.save!
      end
    end
  end
end
