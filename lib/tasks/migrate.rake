namespace :migrate do
  desc 'Call Branch.recount! on each branch'
  task :recount => :environment do

    Branch.all.each do |branch|
      branch.recount!
    end

    Branch.all.each do |branch|
      Redis.current.del("#{branch.name}:srpms:counter")
    end

  end
end

