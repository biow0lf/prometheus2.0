require 'open-uri'

# TODO: refactor
class Acl
  def self.update_redis_cache(vendor, branch, url)
    branch = Branch.where(vendor: vendor, name: branch).first
    file = open(URI.escape(url)).read

    Redis.current.multi

    Maintainer.select('login').each do |maintainer|
      $redis.del("#{branch.name}:maintainers:#{maintainer.login}")
    end

    file.each_line do |line|
      package = line.split[0]
      $redis.del("#{branch.name}:#{package}:acls")
      for i in 1..line.split.count-1
        login = line.split[i]
        login = 'php-coder'    if login == 'php_coder'
        login = 'p_solntsev'   if login == 'psolntsev'
        login = '@vim-plugins' if login == '@vim_plugins'
        $redis.sadd("#{branch.name}:#{package}:acls", login)
        $redis.sadd("#{branch.name}:maintainers:#{login}", package)
      end
    end

    Redis.current.exec
  end
end
