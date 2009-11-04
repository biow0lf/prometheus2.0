require 'open-uri'

namespace :sisyphus do
desc "Import repocop reports to database"
task :repocops => :environment do
  puts "import repocop reports"
  puts Time.now

  ActiveRecord::Base.transaction do
    Repocop.delete_all

    url = "http://repocop.altlinux.org/pub/repocop/prometeus2/prometeus2.txt"
    file = open(URI.escape(url)).read

    ActiveRecord::Base.connection.execute(file)

#    file.each_line do |line|
#      ActiveRecord::Base.connection.execute(line)
#    end

  end

  puts Time.now
end
end
