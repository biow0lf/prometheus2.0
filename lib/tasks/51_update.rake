namespace :"51" do
  namespace :update do
    desc "Update *.src.rpm from 5.1 to database"
    task :srpms => :environment do
      require 'rpm'
      puts Time.now.to_s + ": update *.src.rpm from 5.1 to database"      
      path = "/ALT/5.1/files/SRPMS/*.src.rpm"
      branch = Branch.first :conditions => { :name => '5.1', :vendor => 'ALT Linux' }
      Dir.glob(path).each do |file|
        begin
          rpm = RPM::Package::open(file)
          if !$redis.exists branch.name + ":" + rpm.name
            Srpm.import_srpm(branch.vendor, branch.name, file)            
          else
            curr = $redis.get branch.name + ":" + rpm.name
            if curr != (rpm.version.v.to_s + "-" + rpm.version.r.to_s) and curr != (rpm[1003].to_s + ":" + rpm.version.v.to_s + "-" + rpm.version.r.to_s)
              Srpm.update_srpm(branch.vendor, branch.name, file)
            end  
          end
        rescue RuntimeError
          puts "Bad src.rpm -- " + file
        end
      end
      puts Time.now.to_s + ": end"
    end
    
    desc "Update *.i586.rpm/*.x86_64.rpm/*.noarch.rpm from 5.1 to database"
    task :binary => :environment do
      require 'rpm'
      puts Time.now.to_s + ": update *.i586.rpm/*.x86_64.rpm/*.noarch.rpm from 5.1 to database"
      path_array = ["/ALT/5.1/files/i586/RPMS/*.i586.rpm",
                    "/ALT/5.1/files/x86_64/RPMS/*.x86_64.rpm",
                    "/ALT/5.1/files/noarch/RPMS/*.noarch.rpm"]
      branch = Branch.first :conditions => { :name => '5.1', :vendor => 'ALT Linux' }
      path_array.each do |path|
        Dir.glob(path).each do |file|
          begin
            rpm = RPM::Package::open(file)
            if !$redis.exists branch.name + ":" + rpm[1044] + ":" + rpm.arch + ":" + rpm.name
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