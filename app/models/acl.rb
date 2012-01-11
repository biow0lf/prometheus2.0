# encoding: utf-8

class Acl
  def self.create_redis_cache(vendor_name, branch_name, url)
    branch = Branch.where(vendor: vendor_name, name: branch_name).first
    file = open(URI.escape(url)).read
    Maintainer.all.each { |maintainer| $redis.del("#{branch.name}:maintainers:#{maintainer.login}") }
    file.each_line do |line|
      package = line.split[0]
      $redis.sadd("#{branch.name}:maintainers:#{login}", package)
      for i in 1..line.split.count-1
        login = line.split[i]
        login = 'php-coder' if login == 'php_coder'
        login = 'p_solntsev' if login == 'psolntsev'
        login = '@vim-plugins' if login == '@vim_plugins'
        $redis.sadd("#{branch.name}:#{package}:acls", login)
      end
    end
  end

  def self.update_redis_cache(vendor_name, branch_name, url)
    branch = Branch.where(vendor: vendor_name, name: branch_name).first
    file = open(URI.escape(url)).read
    $redis.multi
    Maintainer.all.each { |maintainer| $redis.del("#{branch.name}:maintainers:#{maintainer.login}") }
    file.each_line do |line|
      package = line.split[0]
      $redis.sadd("#{branch.name}:maintainers:#{login}", package)
      $redis.del("#{branch.name}:#{package}:acls")
      for i in 1..line.split.count-1
        login = line.split[i]
        login = 'php-coder' if login == 'php_coder'
        login = 'p_solntsev' if login == 'psolntsev'
        login = '@vim-plugins' if login == '@vim_plugins'
        $redis.sadd("#{branch.name}:#{package}:acls", login)
      end
    end
    $redis.exec
  end
end
