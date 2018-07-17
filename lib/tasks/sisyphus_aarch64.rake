# frozen_string_literal: true

namespace :update do
  namespace :sisyphus do
    desc 'Update Sisyphus stuff'
    task aarch64: [:environment, :"update:stopredis"] do
      puts "#{ Time.zone.now }: update *.aarch64.rpm from Sisyphus to database"
      pathes = ['/ALT/Sisyphus/files/aarch64/RPMS/*.aarch64.rpm']
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
