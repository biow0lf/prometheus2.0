namespace :sisyphus do
  namespace :update do
    desc "Update *.src.rpm from Sisyphus to database"
    task :srpms => :environment do
      require 'rpm'
      puts Time.now.to_s + ": update *.src.rpm from Sisyphus to database"
      path = "/ALT/Sisyphus/files/SRPMS/*.src.rpm"
      branch = Branch.first :conditions => { :name => 'Sisyphus', :vendor => 'ALT Linux' }
      Dir.glob(path).each do |file|
        begin
          if !$redis.exists branch.name + ":" + file.split('/')[-1]
            puts Time.now.to_s + ": update '" + file.split('/')[-1] + "'"
            Srpm.import_srpm(branch.vendor, branch.name, file)
          end
        rescue RuntimeError
          puts "Bad src.rpm -- " + file
        end
      end
      puts Time.now.to_s + ": end"
    end

    desc "Update *.i586.rpm/*.x86_64.rpm/*.noarch.rpm from Sisyphus to database"
    task :binary => :environment do
      require 'rpm'
      puts Time.now.to_s + ": update *.i586.rpm/*.x86_64.rpm/*.noarch.rpm from Sisyphus to database"
      path_array = ["/ALT/Sisyphus/files/i586/RPMS/*.i586.rpm",
                    "/ALT/Sisyphus/files/x86_64/RPMS/*.x86_64.rpm",
                    "/ALT/Sisyphus/files/noarch/RPMS/*.noarch.rpm"]
      branch = Branch.first :conditions => { :name => 'Sisyphus', :vendor => 'ALT Linux' }
      path_array.each do |path|
        Dir.glob(path).each do |file|
          begin
            if !$redis.exists branch.name + ":" + file.split('/')[-1]
              puts Time.now.to_s + ":update '" + file.split('/')[-1] + "'"
              Package.import_rpm(branch.vendor, branch.name, file)
            end
          rescue RuntimeError
            puts "Bad src.rpm -- " + file
          end
        end
      end
      puts Time.now.to_s + ": end"
    end

#    desc "Update maintainers list from Sisyphus to database"
#    task :maintainers => :environment do
#      require 'rpm'
#      puts Time.now.to_s + ": update maintainers list from Sisyphus to database"
#      ActiveRecord::Base.transaction do
#        Maintainer.delete_all
#        Maintainer.update_maintainer_list 'ALT Linux', 'Sisyphus', "/ALT/Sisyphus/files/SRPMS/*.src.rpm"
#      end
#      puts Time.now.to_s + ": end"
#    end
  end
end