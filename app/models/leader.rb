# frozen_string_literal: true

require 'open-uri'

class Leader
  class << self
    def update_redis_cache(branch, url)
      file = open(URI.escape(url)).read
      Redis.current.multi

      branch.srpms.select('name').all.each do |srpm|
        Redis.current.del("#{ branch.name }:#{ srpm.name }:leader")
      end

      file.each_line do |line|
        package = line.split[0]
        Redis.current.del("#{ branch.name }:#{ package }:leader")
        login = line.split[1]
        login = 'php-coder' if login == 'php_coder'
        login = 'p_solntsev' if login == 'psolntsev'
        login = '@vim-plugins' if login == '@vim_plugins'
        Redis.current.set("#{ branch.name }:#{ package }:leader", login)
      end

      Redis.current.exec
    rescue OpenURI::HTTPError
      nil
    end
  end
end
