namespace :sisyphusarm do
  namespace :update do
    desc "Update *.src.rpm from SisyphusARM to database"
    task :srpms => :environment do
      require 'rpm'
      puts Time.now.to_s + ": update *.src.rpm from SisyphusARM to database"      
      path = "/ALT/Sisyphus/arm/SRPMS.all/*.src.rpm"
      branch = Branch.first :conditions => { :name => 'SisyphusARM', :vendor => 'ALT Linux' }
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

    desc "Update *.arm.rpm/*.noarch.rpm from SisyphusARM to database"
    task :binary => :environment do
      require 'rpm'
      puts Time.now.to_s + ": update *.arm.rpm/*.noarch.rpm from SisyphusARM to database"
      path_array = ["/ALT/Sisyphus/files/arm/RPMS/*.rpm"]
      branch = Branch.first :conditions => { :name => 'SisyphusARM', :vendor => 'ALT Linux' }
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