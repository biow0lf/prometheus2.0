namespace :t6 do
  desc "Update t6 stuff"
  task :update => :environment do
    require 'rpm'
    require 'open-uri'

    branch = Branch.where(:name => 't6', :vendor => 'ALT Linux').first

    ActiveRecord::Base.transaction do
      puts "#{Time.now.to_s}: Update t6 stuff"
      puts "#{Time.now.to_s}: update *.src.rpm from t6 to database"
      path = '/ALT/t6/files/SRPMS/*.src.rpm'
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

      puts "#{Time.now.to_s}: update *.i586.rpm/*.x86_64.rpm/*.noarch.rpm from t6 to database"
      path_array = ['/ALT/t6/files/i586/RPMS/*.i586.rpm',
                    '/ALT/t6/files/x86_64/RPMS/*.x86_64.rpm',
                    '/ALT/t6/files/noarch/RPMS/*.noarch.rpm']
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

      Srpm.remove_old_srpms('ALT Linux', 't6', '/ALT/t6/files/SRPMS/')
    end

    puts "#{Time.now.to_s}: expire cache"
    ['en', 'ru', 'uk', 'br'].each do |locale|
      ActionController::Base.new.expire_fragment("#{locale}_srpms_#{branch.name}_")
    end

    puts "#{Time.now.to_s}: update acls in redis cache"
    Acl.update_redis_cache('ALT Linux', 't6', 'http://git.altlinux.org/acl/list.packages.t6')

    puts "#{Time.now.to_s}: end"
  end
end
