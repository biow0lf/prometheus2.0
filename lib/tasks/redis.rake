namespace :sisyphus do
  namespace :redis do

    desc "Cache srpm info for Sisyphus in redis"
    task :cache => :environment do

      branch = Branch.first :conditions => { :name => 'Sisyphus', :vendor => 'ALT Linux' }

      srpms = Srpm.all :conditions => { :branch_id => branch.id }

      puts srpms.count

      srpms.each do |srpm|
        $redis.set branch.name + srpm.name, srpm.version + srpm.release
      end

    end

  end

end