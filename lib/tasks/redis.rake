# encoding: utf-8

namespace :redis do
  desc 'Cache all *.src.rpm and all binary *.rpm in redis'
  task :cache => :environment do
    require 'open-uri'

    puts "#{Time.now.to_s}: cache all *.src.rpm info in redis"
    branches = Branch.where(:vendor => 'ALT Linux')
    branches.each do |branch|
      srpms = Srpm.where(:branch_id => branch).select('filename')
      srpms.each { |srpm| $redis.set("#{branch.name}:#{srpm.filename}", 1) }
    end
    puts "#{Time.now.to_s}: end"

    puts "#{Time.now.to_s}: cache all binary files info in redis"
    branches.each do |branch|
      packages = Package.where(:branch_id => branch).select('filename')
      packages.each { |package| $redis.set("#{branch.name}:#{package.filename}", 1) }
    end
    puts "#{Time.now.to_s}: end"

    puts "#{Time.now.to_s}: cache all acls in redis"
    Acl.create_redis_cache('ALT Linux', 'Sisyphus', 'http://git.altlinux.org/acl/list.packages.sisyphus')
    Acl.create_redis_cache('ALT Linux', '5.1', 'http://git.altlinux.org/acl/list.packages.5.1')
    Acl.create_redis_cache('ALT Linux', '5.0', 'http://git.altlinux.org/acl/list.packages.5.0')
    Acl.create_redis_cache('ALT Linux', '4.1', 'http://git.altlinux.org/acl/list.packages.4.1')
    Acl.create_redis_cache('ALT Linux', '4.0', 'http://git.altlinux.org/acl/list.packages.4.0')
    puts "#{Time.now.to_s}: end"

  end
end
