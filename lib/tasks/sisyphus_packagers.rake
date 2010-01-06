namespace :sisyphus do
desc "Import packagers list from src.rpm from Sisyphus to database"
task :packagers => :environment do
  require 'rpm'

  puts "import src.rpm's"
  puts Time.now

  branch = Branch.find :first, :conditions => { :name => 'Sisyphus' }

  Packager.update_packager_list "ALT Linux", "Sisyphus"

  puts Time.now
end
end
