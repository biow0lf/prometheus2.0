namespace :sisyphus do
  namespace :redis do
    desc "Cache srpm info for Sisyphus in redis"
    task :cache => :environment do
      branch = Branch.first :conditions => { :name => 'Sisyphus', :vendor => 'ALT Linux' }
      if $redis.exists "Sisyphus:glibc"
        srpms = Srpm.all :conditions => { :branch_id => branch.id }
        srpms.each do |srpm|
          if srpm.epoch.nil?
            $redis.set branch.name + ":" + srpm.name, srpm.version + "-" + srpm.release
          else
            $redis.set branch.name + ":" + srpm.name, srpm.epoch + ":" + srpm.version + "-" + srpm.release
          end
        end
      else
        puts Time.now.to_s + ": srpm info for Sisyphus already cached"
      end
    end
  end
end