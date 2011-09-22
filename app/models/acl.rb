class Acl < ActiveRecord::Base
  belongs_to :branch
  belongs_to :maintainer
  belongs_to :srpm

  validates :branch, presence: true
  validates :maintainer, presence: true
  validates :srpm, presence: true

  def self.import_acls(vendor_name, branch_name, url)
    branch = Branch.where(name: branch_name, vendor: vendor_name).first
    if branch.acls.count(:all) == 0
      ActiveRecord::Base.transaction do
        file = open(URI.escape(url)).read
        file.each_line do |line|
          package = line.split[0]
          for i in 1..line.split.count-1
            login = line.split[i]
            login = 'php-coder' if login == 'php_coder'
            login = 'p_solntsev' if login == 'psolntsev'
            login = '@vim-plugins' if login == '@vim_plugins'

            maintainer = Maintainer.where(login: login).first
            srpm = branch.srpms.where(name: package).first

            if maintainer.nil?
              puts "#{Time.now.to_s}: maintainer not found '#{login}'"
            elsif srpm.nil?
              puts "#{Time.now.to_s}: srpm not found '#{package}'"
            else
              Acl.create(srpm: srpm, maintainer: maintainer, branch: branch)
            end
          end
        end
      end
    else
      puts "#{Time.now.to_s}: acls already imported"
    end
  end

  def self.create_acls_for_package(vendor_name, branch_name, url, package)
    branch = Branch.where(name: branch_name, vendor: vendor_name).first
    branch.srpms.where(name: package).first.acls.delete_all
    file = open(URI.escape(url)).read
    file.each_line do |line|
      packagename = line.split[0]
      if packagename == package
        srpm = branch.srpms.where(name: packagename).first
        for i in 1..line.split.count-1
          login = line.split[i]
          login = 'php-coder' if login == 'php_coder'
          login = 'p_solntsev' if login == 'psolntsev'
          login = '@vim-plugins' if login == '@vim_plugins'
          maintainer = Maintainer.where(login: login).first
          if maintainer.nil?
            puts "#{Time.now.to_s}: maintainer not found '#{login}'"
          else
            Acl.create(srpm: srpm, maintainer: maintainer, branch: branch)
          end
        end
      end
    end
  end

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
        if i == 1
          $redis.zadd("#{branch.name}:#{package}:acls", 1, login)
        else
          $redis.zadd("#{branch.name}:#{package}:acls", 10, login)
        end
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
        if i == 1
          $redis.zadd("#{branch.name}:#{package}:acls", 1, login)
        else
          $redis.zadd("#{branch.name}:#{package}:acls", 10, login)
        end
      end
      $redis.exec
    end
  end
end
