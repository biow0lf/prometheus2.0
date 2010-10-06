namespace :redis do
  desc "Cache all srpm info in redis"
  task :cache => :environment do
    puts Time.now.to_s + ": cache all srpm info in redis"
    branches = Branch.all :conditions => { :vendor => 'ALT Linux' }
    branches.each do |branch|
      if !$redis.exists branch.name + ":glibc"
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
end