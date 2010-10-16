namespace :"41" do
  namespace :update do
    desc "Update *.src.rpm from 4.1 to database"
    task :srpms => :environment do
      require 'rpm'
      puts Time.now.to_s + ": update *.src.rpm from 4.1 to database"      
      path = "/ALT/4.1/files/SRPMS/*.src.rpm"
      branch = Branch.first :conditions => { :name => '4.1', :vendor => 'ALT Linux' }
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

    desc "Update *.i586.rpm/*.x86_64.rpm/*.noarch.rpm from 4.1 to database"
    task :binary => :environment do
      require 'rpm'
      puts Time.now.to_s + ": update *.i586.rpm/*.x86_64.rpm/*.noarch.rpm from 4.1 to database"
      path_array = ["/ALT/4.1/files/i586/RPMS/*.i586.rpm",
                    "/ALT/4.1/files/x86_64/RPMS/*.x86_64.rpm",
                    "/ALT/4.1/files/noarch/RPMS/*.noarch.rpm"]
      branch = Branch.first :conditions => { :name => '4.1', :vendor => 'ALT Linux' }
      path_array.each do |path|
        Dir.glob(path).each do |file|
          begin
            if !$redis.exists branch.name + ":" + file.split('/')[-1]
              puts Time.now.to_s + ": update '" + file.split('/')[-1] + "'"
              Package.import_rpm(branch.vendor, branch.name, file)
            end
          rescue RuntimeError
            puts "Bad src.rpm -- " + file
          end
        end
      end
      puts Time.now.to_s + ": end"
    end
  end
end