require 'open-uri'

desc "Import repocop reports to database"
task :repocop => :environment do
  puts "import repocop reports"
  puts Time.now

  Repocop.transaction do
    Repocop.delete_all

    url = "http://repocop.altlinux.org/pub/repocop/heroku/heroku.txt"
    f = open(URI.escape(url)).read

    f.each_line do |line|
      Repocop.create(:name       => line.split('|||')[0],
                     :version    => line.split('|||')[1],
                     :release    => line.split('|||')[2],
                     :arch       => line.split('|||')[3],
                     :srcname    => line.split('|||')[4],
                     :srcversion => line.split('|||')[5],
                     :srcrel     => line.split('|||')[6],
                     :testname   => line.split('|||')[7],
                     :status     => line.split('|||')[8],
                     :message    => line.split('|||')[9]
                     )
    end
  end
  puts Time.now
end

