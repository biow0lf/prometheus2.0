namespace :migrate do
  desc 'Call Branch.recount! on each branch'
  task :recount => :environment do

    Branch.all.each do |branch|
      branch.recount!
    end

    Branch.all.each do |branch|
      Redis.current.del("#{ branch.name }:srpms:counter")
    end

  end

  desc 'Migrate :size string to :size integer'
  task :size => :environment do
    Srpm.find_each do |srpm|
      srpm.size_integer = srpm.size.to_i
      srpm.save!
    end

    Package.find_each do |package|
      package.size_integer = package.size.to_i
      package.save!
    end
  end
end
