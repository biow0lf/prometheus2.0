namespace :redis do
  desc "Cache all srpm info in redis"
  task :cache => :environment do
    puts Time.now.to_s + ": cache all srpm info in redis"
    branches = Branch.all :conditions => { :vendor => 'ALT Linux' }
    branches.each do |branch|
      if !$redis.exists branch.name + ":CACHED"
        srpms = Srpm.all :conditions => { :branch_id => branch.id }
        srpms.each do |srpm|
          if srpm.epoch.nil?
            $redis.set branch.name + ":" + srpm.name, srpm.version + "-" + srpm.release
          else
            $redis.set branch.name + ":" + srpm.name, srpm.epoch + ":" + srpm.version + "-" + srpm.release
          end
        end
      else
        puts Time.now.to_s + ": srpm info for " + branch.name + " already in cache"
      end
    end
    puts Time.now.to_s + ": end"
  end

  desc "Cache all binary files info in redis"
  task :cache_binary => :environment do
    puts Time.now.to_s + ": cache all binary files info in redis"
    branches = Branch.all :conditions => { :vendor => 'ALT Linux' }
    branches.each do |branch|
      if !$redis.exists branch.name + ":CACHED"
        packages = Package.all :conditions => { :branch_id => branch.id }
        packages.each do |package|
          if package.epoch.nil?
            $redis.set branch.name + ":" + package.sourcepackage + ":" + package.name, package.version + "-" + package.release
          else
            $redis.set branch.name + ":" + package.sourcepackage + ":" + package.name, package.epoch.to_s + ":" + package.version + "-" + package.release
          end
        end
      else
        puts Time.now.to_s + ": binary files info for " + branch.name + " already in cache"
      end
    end
    puts Time.now.to_s + ": end"
  end
end