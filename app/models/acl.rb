require 'open-uri'

class Acl
  def self.update_redis_cache(branch, url)
    file = open(URI.escape(url)).read
    Redis.current.multi
    Maintainer.select('login').each do |maintainer|
      Redis.current.del("#{ branch.name }:maintainers:#{ maintainer.login }")
    end
    file.each_line do |line|
      package = line.split[0]
      Redis.current.del("#{ branch.name }:#{ package }:acls")
      for i in 1..line.split.count-1
        login = line.split[i]
        login = 'php-coder' if login == 'php_coder'
        login = 'p_solntsev' if login == 'psolntsev'
        login = '@vim-plugins' if login == '@vim_plugins'
        Redis.current.sadd("#{ branch.name }:#{ package }:acls", login)
        Redis.current.sadd("#{ branch.name }:maintainers:#{ login }", package)
      end
    end
    Redis.current.exec
  end
end
