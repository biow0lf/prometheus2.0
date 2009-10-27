require 'open-uri'

namespace :sisyphus do
desc "Import all ACL for packages from Sisyphus to database (leaders)"
task :leaders => :environment do
  puts "import leaders"
  puts Time.now

  Leader.transaction do
    Leader.delete_all

    branch = Branch.find :first, :conditions => { :urlname => 'Sisyphus' }
    url = branch.acls_url

    file = open(URI.escape(url)).read

    file.each_line do |line|
      package = line.split[0]
      login = line.split[1]
      Leader.create :package => package, :login => login, :branch_id => branch.id
    end
  end
  puts Time.now
end
end
