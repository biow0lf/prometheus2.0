namespace :sisyphus do
task :x86_64 => :environment do
  require 'rpm'

  puts "import x86_64.rpm's"
  puts Time.now

  Package.update_packages_x86_64 'ALT Linux', 'Sisyphus'

  puts Time.now
end
end
