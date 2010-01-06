namespace :sisyphus do
task :i586 => :environment do
  require 'rpm'

  puts "import i586.rpm's"
  puts Time.now

  Package.update_packages_i586 'ALT Linux', 'Sisyphus'

  puts Time.now
end
end
