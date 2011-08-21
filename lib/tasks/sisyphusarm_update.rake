namespace :sisyphusarm do
  desc "Update SisyphusARM stuff"
  task :update => :environment do
    require 'rpm'
    require 'open-uri'

    branch = Branch.where(:name => 'SisyphusARM', :vendor => 'ALT Linux').first

    ActiveRecord::Base.transaction do
      puts "#{Time.now.to_s}: Update SisyphusARM stuff"
      puts "#{Time.now.to_s}: update *.src.rpm from SisyphusARM to database"
      path = '/ALT/Sisyphus/arm/SRPMS.all/*.src.rpm'
      Dir.glob(path).each do |file|
        begin
          if !$redis.exists "#{branch.name}:#{file.split('/')[-1]}"
            puts "#{Time.now.to_s}: updating '#{file.split('/')[-1]}'"
            Srpm.import_srpm(branch.vendor, branch.name, file)
          end
        rescue RuntimeError
          puts "Bad .src.rpm: #{file}"
        end
      end

      puts "#{Time.now.to_s}: update *.arm.rpm/*.noarch.rpm from SisyphusARM to database"
      path_array = ['/ALT/Sisyphus/files/arm/RPMS/*.rpm']
      path_array.each do |path|
        Dir.glob(path).each do |file|
          begin
            if !$redis.exists "#{branch.name}:#{file.split('/')[-1]}"
              puts "#{Time.now.to_s}: update '#{file.split('/')[-1]}'"
              Package.import_rpm(branch.vendor, branch.name, file)
            end
          rescue RuntimeError
            puts "Bad .rpm: #{file}"
          end
        end
      end

      Srpm.remove_old_srpms('ALT Linux', 'Sisyphus', '/ALT/Sisyphus/files/SRPMS/')
    end

    puts "#{Time.now.to_s}: expire cache"
    ['en', 'ru', 'uk', 'br'].each do |locale|
      ActionController::Base.new.expire_fragment("#{locale}_srpms_#{branch.name}_")
    end

    puts "#{Time.now.to_s}: end"
  end
end
