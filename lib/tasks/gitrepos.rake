require 'open-uri'

namespace :sisyphus do
desc "Import all git repos to database"
task :gitrepos => :environment do
  puts "import gitrepos"
  puts Time.now

  Gitrepos.transaction do
    Gitrepos.delete_all

    url = "http://git.altlinux.org/people-packages-list"
    f = open(URI.escape(url)).read

    f.each_line do |line|
      gitrepo = line.split[0]
      login = gitrepo.split('/')[2]
      login = 'php-coder' if login == 'php_coder'
      package = gitrepo.split('/')[4]
      time = Time.at(line.split[1].to_i)
      Gitrepos.create(:package => package.gsub(/\.git/,''), :login => login, :lastchange => time)
    end
  end
  puts Time.now
end
end
