namespace :sisyphus do
desc "Import all git repos to database"
task :gitrepos => :environment do
  require 'open-uri'
  puts Time.now.to_s + ": import gitrepos"

  ActiveRecord::Base.transaction do
    Gitrepo.delete_all

    url = "http://git.altlinux.org/people-packages-list"
    file = open(URI.escape(url)).read

    file.each_line do |line|
      gitrepo = line.split[0]
      login = gitrepo.split('/')[2]
      login = 'php-coder' if login == 'php_coder'
      package = gitrepo.split('/')[4]
      time = Time.at(line.split[1].to_i)
      Gitrepo.create(:repo => package.gsub(/\.git/,''), :login => login, :lastchange => time)
    end
  end
  puts Time.now.to_s + ": end"
end
end
