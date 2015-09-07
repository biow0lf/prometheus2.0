namespace :p5 do
  desc 'Update p5 stuff'
  task update: :environment do
    puts "#{ Time.now }: Update p5 stuff"
    if Redis.current.get('__SYNC__')
      exist = begin
                Process.kill(0, Redis.current.get('__SYNC__').to_i)
                true
              rescue
                false
              end
      if exist
        puts "#{ Time.now }: update is locked by another cron script"
        Process.exit!(true)
      else
        puts "#{ Time.now }: dead lock found and deleted"
        Redis.current.del('__SYNC__')
      end
    end
    Redis.current.set('__SYNC__', Process.pid)
    puts "#{ Time.now }: update *.src.rpm from p5 to database"
    branch = Branch.find_by!(name: 'Platform5')
    ThinkingSphinx::Deltas.suspend! if ENV['PROMETHEUS2_BOOTSTRAP'] == 'yes'
    Srpm.import_all(branch, '/ALT/p5/files/SRPMS/*.src.rpm')
    Srpm.remove_old(branch, '/ALT/p5/files/SRPMS/')
    puts "#{ Time.now }: end"
    puts "#{ Time.now }: update *.i586.rpm/*.noarch.rpm/*.x86_64.rpm from Platform5 to database"
    pathes = ['/ALT/p5/files/i586/RPMS/*.i586.rpm',
              '/ALT/p5/files/noarch/RPMS/*.noarch.rpm',
              '/ALT/p5/files/x86_64/RPMS/*.x86_64.rpm']
    Package.import_all(branch, pathes)
    ThinkingSphinx::Deltas.resume! if ENV['PROMETHEUS2_BOOTSTRAP'] == 'yes'
    puts "#{ Time.now }: end"
    puts "#{ Time.now }: update acls in redis cache"
    Acl.update_redis_cache(branch, 'http://git.altlinux.org/acl/list.packages.p5')
    puts "#{ Time.now }: end"
    puts "#{ Time.now }: update leaders in redis cache"
    Leader.update_redis_cache(branch, 'http://git.altlinux.org/acl/list.packages.p5')
    puts "#{ Time.now }: end"
    puts "#{ Time.now }: update time"
    Redis.current.set("#{ branch.name }:updated_at", Time.now.to_s)
    puts "#{ Time.now }: end"
    Redis.current.del('__SYNC__')
  end

  # TODO: remove this
  # desc "Import all teams from Platform5 to database"
  # task teams: :environment do
  #   require 'open-uri'
  #   puts "#{ Time.now }: import teams"
  #   Team.import_teams('ALT Linux', 'Platform5', 'http://git.altlinux.org/acl/list.groups.p5')
  #   puts "#{ Time.now }: end"
  # end
end
