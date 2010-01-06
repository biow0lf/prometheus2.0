namespace :sisyphus do
desc "Import src.rpm from Sisyphus to database"
task :srpms => :environment do
  require 'rpm'

  puts "import src.rpm's"
  puts Time.now

  Srpm.import_srpms "ALT Linux", "Sisyphus"

  puts Time.now
end
end
