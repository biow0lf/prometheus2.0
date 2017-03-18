require 'open-uri'

class UpdateAcls < Rectify::Command
  attr_reader :branch

  def initialize(branch)
    @branch = branch
  end

  def call
    return unless branch.acls_url

    Redis.current.multi

    remove_branch_maintainers_acls

    update_acls

    Redis.current.exec

    broadcast(:ok)
  end

  private

  def file
    @file ||= open(URI.escape(branch.acls_url)).read
  end

  def extract_package_name(line)
    line.split("\t").first
  end

  def logins(line)
    line.split("\n").last.split(' ')
  end

  def remove_branch_maintainers_acls
    Maintainer.pluck('login').each do |login|
      Redis.current.del("#{ branch.name }:maintainers:#{ login }")
    end
  end

  def update_acls
    file.split("\n").each do |line|
      package = extract_package_name(line)

      remove_acls(package)

      logins(line).each do |login|
        add_acl(package, login)
      end
    end
  end

  def remove_acls(package)
    Redis.current.del("#{ branch.name }:#{ package }:acls")
  end

  def add_acl(package, login)
    Redis.current.sadd("#{ branch.name }:#{ package }:acls", login)
    Redis.current.sadd("#{ branch.name }:maintainers:#{ login }", package)
  end
end
