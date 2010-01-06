namespace :sisyphus do
task :noarch => :environment do
  require 'rpm'

  puts "import noarch.rpm's"
  puts Time.now

  Package.update_packages_noarch 'ALT Linux', 'Sisyphus'

  puts Time.now
end
end
