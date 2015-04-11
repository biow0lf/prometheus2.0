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

  desc 'Migrate :size string to :size integer'
  task size: :environment do
    ThinkingSphinx::Deltas.suspend!

    Srpm.find_each do |srpm|
      srpm.size_integer = srpm.size.to_i
      srpm.save(validate: false)
    end

    Package.find_each do |package|
      package.size_integer = package.size.to_i
      package.save(validate: false)
    end

    ThinkingSphinx::Deltas.resume!
  end

  desc 'Migrate :changelogtime string to datetime'
  task changelogtime: :environment do
    ThinkingSphinx::Deltas.suspend!

    Srpm.find_each do |srpm|
      srpm.changelogtime_datetime = Time.at(srpm.changelogtime.to_i)
      srpm.save(validate: false)
    end

    ThinkingSphinx::Deltas.resume!
  end

  desc 'Migrate :epoch string to :epoch integer'
  task epoch: :environment do
    ThinkingSphinx::Deltas.suspend!

    Srpm.find_each do |srpm|
      if srpm.epoch
        srpm.epoch_int = srpm.epoch.to_i
      else
        srpm.epoch_int = nil
      end
      srpm.save(validate: false)
    end

    Package.find_each do |package|
      if package.epoch
        package.epoch_int = package.epoch.to_i
      else
        package.epoch_int = nil
      end
      package.save(validate: false)
    end

    ThinkingSphinx::Deltas.resume!
  end
end
