# encoding: utf-8

class Leader
  def self.update_redis_cache(vendor_name, branch_name, url)
    branch = Branch.where(name: branch_name, vendor: vendor_name).first
    file = open(URI.escape(url)).read
    $redis.multi

    branch.srpms.select('name').all.each do |srpm|
      $redis.del("#{branch.name}:#{srpm.name}:leader")
    end

    file.each_line do |line|
      package = line.split[0]
      $redis.del("#{branch.name}:#{package}:leader")
      login = line.split[1]
      login = 'php-coder' if login == 'php_coder'
      login = 'p_solntsev' if login == 'psolntsev'
      login = '@vim-plugins' if login == '@vim_plugins'
      $redis.set("#{branch.name}:#{package}:leader", login)
    end

    $redis.exec
  end
end
