# frozen_string_literal: true

namespace :mips do
  desc 'Update Sisyphus MIPS stuff'
  task update: [:environment, :'update:lock'] do
    puts "#{ Time.zone.now }: update *.src.rpm from Sisyphus MIPS to database"
    branch = Branch.find_by!(name: 'SisyphusMips')
    Srpm.import_all(branch, '/ALT/SisyphusMips/files/SRPMS/*.src.rpm')
    RemoveOldSrpms.call(branch, '/ALT/SisyphusMips/files/SRPMS/') do
      on(:ok) { puts "#{ Time.zone.now }: Old srpms removed" }
    end
    puts "#{ Time.zone.now }: update *.mips.rpm/*.noarch.rpm from Sisyphus to database"
    pathes = ['/ALT/Sisyphus/files/mips/RPMS/*.i586.rpm',
              '/ALT/Sisyphus/files/noarch/RPMS/*.noarch.rpm']
    Package.import_all(branch, pathes)
    puts "#{ Time.zone.now }: end"
    puts "#{ Time.zone.now }: update acls in redis cache"
    Acl.update_redis_cache(branch, 'http://git.altlinux.org/acl/list.packages.sisyphus')
    puts "#{ Time.zone.now }: end"
    puts "#{ Time.zone.now }: update leaders in redis cache"
    Leader.update_redis_cache(branch, 'http://git.altlinux.org/acl/list.packages.sisyphus')
    puts "#{ Time.zone.now }: end"
    puts "#{ Time.zone.now }: update time"
    Redis.current.set("#{ branch.name }:updated_at", Time.now.to_s)
    puts "#{ Time.zone.now }: end"
    Redis.current.del('__SYNC__')
  end
end
