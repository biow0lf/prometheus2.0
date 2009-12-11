namespace :sisyphus do
desc "Import all ACL for packages from Sisyphus to database (leaders)"
task :leaders => :environment do
  require 'open-uri'

  puts "import leaders"
  puts Time.now

  ActiveRecord::Base.transaction do
    branch = Branch.find :first, :conditions => { :urlname => 'Sisyphus' }
    ActiveRecord::Base.connection.execute("DELETE FROM leaders WHERE branch_id = " + branch.id.to_s)

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
