require 'open-uri'

desc "Import list of ftbfs packages on i586 to database"
task :ftbfs_i586 => :environment do
  puts "import ftbfs_i586"
  puts Time.now

  Ftbfs.transaction do
    Ftbfs.delete_all

    url = "http://git.altlinux.org/packages-ftbfs-i586.txt"
    f = open(URI.escape(url)).read

    f.each_line do |line|
      name = line.split[0]
#      version = line.split[1]
#      release = line.split[2]
      weeks = line.split[2]
      logins = line.split[3]
      logins.split(',').each do |l|
#        Ftbfs.create(:name => name, :version => version, :release => release, :weeks => weeks, :login => l)
        Ftbfs.create(:name => name, :weeks => weeks, :login => l)
      end
    end
  end
  puts Time.now
end

