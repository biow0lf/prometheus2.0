namespace :migrate do
  desc 'Update all srpms with groupname'
  task :recount => :environment do

    Branch.all.each do |branch|
      branch.recount!
    end

  end
end

