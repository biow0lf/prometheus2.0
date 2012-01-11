# encoding: utf-8

class Acl < ActiveRecord::Base
  belongs_to :branch
  belongs_to :maintainer
  belongs_to :srpm

  validates :branch, presence: true
  validates :maintainer, presence: true
  validates :srpm, presence: true

  def self.create_redis_cache(vendor_name, branch_name, url)
    branch = Branch.where(vendor: vendor_name, name: branch_name).first
    file = open(URI.escape(url)).read
    file.each_line do |line|
      package = line.split[0]
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
    file.each_line do |line|
      package = line.split[0]
      $redis.multi
      $redis.del("#{branch.name}:#{package}:acls")
      for i in 1..line.split.count-1
        login = line.split[i]
        login = 'php-coder' if login == 'php_coder'
        login = 'p_solntsev' if login == 'psolntsev'
        login = '@vim-plugins' if login == '@vim_plugins'
        $redis.sadd("#{branch.name}:#{package}:acls", login)
      end
      $redis.exec
    end
  end
end
