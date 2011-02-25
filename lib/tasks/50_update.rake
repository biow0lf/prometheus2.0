namespace :"50" do
  desc "Update 5.0 stuff"
  task :update => :environment do
    require 'rpm'
    require 'open-uri'

    ActiveRecord::Base.transaction do
      puts "#{Time.now.to_s}: Update 5.0 stuff"
      puts "#{Time.now.to_s}: update *.src.rpm from 5.0 to database"
      path = '/ALT/5.0/files/SRPMS/*.src.rpm'
      branch = Branch.where(:name => '5.0', :vendor => 'ALT Linux').first
      Dir.glob(path).each do |file|
        begin
          if !$redis.exists branch.name + ":" + file.split('/')[-1]
            puts "#{Time.now.to_s}: updating '#{file.split('/')[-1]}'"
            Srpm.import_srpm(branch.vendor, branch.name, file)
          end
        rescue RuntimeError
          puts "Bad .src.rpm: #{file}"
        end
      end

      puts "#{Time.now.to_s}: update *.i586.rpm/*.x86_64.rpm/*.noarch.rpm from 5.0 to database"
      path_array = ['/ALT/5.0/files/i586/RPMS/*.i586.rpm',
                    '/ALT/5.0/files/x86_64/RPMS/*.x86_64.rpm',
                    '/ALT/5.0/files/noarch/RPMS/*.noarch.rpm']
      path_array.each do |path|
        Dir.glob(path).each do |file|
          begin
            if !$redis.exists branch.name + ':' + file.split('/')[-1]
              puts "#{Time.now.to_s}: update '#{file.split('/')[-1]}'"
              Package.import_rpm(branch.vendor, branch.name, file)
            end
          rescue RuntimeError
            puts "Bad .rpm: #{file}"
          end
        end
      end

      Srpm.remove_old_srpms('ALT Linux', '5.0', '/ALT/5.0/files/SRPMS/')
    end
    puts "#{Time.now.to_s}: end"
  end
end
