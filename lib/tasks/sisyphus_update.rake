namespace :sisyphus do
namespace :update do
desc "Update *.src.rpm from Sisyphus to database"
task :srpms => :environment do
  require 'rpm'
  puts Time.now.to_s + ": update *.src.rpm from Sisyphus to database"
  ActiveRecord::Base.transaction do
    ActiveRecord::Base.connection.execute("DELETE FROM srpms WHERE branch = 'Sisyphus' AND vendor = 'ALT Linux'")
    Srpm.import_srpms 'ALT Linux', 'Sisyphus'
  end
  puts Time.now.to_s + ": end"
end

desc "Update *.i586.rpm from Sisyphus to database"
task :i586 => :environment do
  require 'rpm'
  puts Time.now.to_s + ": update *.i586.rpm from Sisyphus to database"
  ActiveRecord::Base.transaction do
    ActiveRecord::Base.connection.execute("DELETE FROM packages WHERE arch = 'i586' AND branch = 'Sisyphus' AND vendor = 'ALT Linux'")
    Package.import_packages_i586 'ALT Linux', 'Sisyphus'
  end
  puts Time.now.to_s + ": end"
end

desc "Update *.noarch.rpm from Sisyphus to database"
task :noarch => :environment do
  require 'rpm'
  puts Time.now.to_s + ": update *.noarch.rpm from Sisyphus to database"
  ActiveRecord::Base.transaction do
    ActiveRecord::Base.connection.execute("DELETE FROM packages WHERE arch = 'noarch' AND branch = 'Sisyphus' AND vendor = 'ALT Linux'")
    Package.import_packages_noarch 'ALT Linux', 'Sisyphus'
  end
  puts Time.now.to_s + ": end"
end

desc "Update *.x86_64.rpm from Sisyphus to database"
task :x86_64 => :environment do
  require 'rpm'
  puts Time.now.to_s + ": update *.x86_64.rpm from Sisyphus to database"
  ActiveRecord::Base.transaction do
    ActiveRecord::Base.connection.execute("DELETE FROM packages WHERE arch = 'x86_64' AND branch = 'Sisyphus' AND vendor = 'ALT Linux'")
    Package.import_packages_x86_64 'ALT Linux', 'Sisyphus'
  end
  puts Time.now.to_s + ": end"
end

desc "Update packager list from Sisyphus to database"
task :packagers => :environment do
  require 'rpm'
  puts Time.now.to_s + ": update packager list from Sisyphus to database"
  ActiveRecord::Base.transaction do
    Packager.delete_all

    Packager.create(:name => 'Nobody', :email => 'noboby@altlinux.org', :login => '@nobody', :team => true)

    Packager.create(:name => 'Igor Zubkov', :email => 'icesik@altlinux.org', :login => 'icesik', :team => false)
    Packager.create(:name => 'Alexey Tourbin', :email => 'at@altlinux.org', :login => 'at', :team => false)
    Packager.create(:name => 'Alexey I. Froloff', :email => 'raorn@altlinux.org', :login => 'raorn', :team => false)
    Packager.create(:name => 'Eugeny A. Rostovtsev', :email => 'real@altlinux.org', :login => 'real', :team => false)
    Packager.create(:name => 'Alexey Rusakov', :email => 'ktirf@altlinux.org', :login => 'ktirf', :team => false)
    Packager.create(:name => 'Alex Gorbachenko', :email => 'algor@altlinux.org', :login => 'algor', :team => false)
    Packager.create(:name => 'Andriy Stepanov', :email => 'stanv@altlinux.org', :login => 'stanv', :team => false)
    Packager.create(:name => 'Anton Farygin', :email => 'rider@altlinux.org', :login => 'rider', :team => false)
    Packager.create(:name => 'Igor Muratov', :email => 'migor@altlinux.org', :login => 'migor', :team => false)
    Packager.create(:name => 'Mihail A. Pluzhnikov', :email => 'amike@altlinux.org', :login => 'amike', :team => false)
    Packager.create(:name => 'Pavel V. Solntsev', :email => 'p_solntsev@altlinux.org', :login => 'p_solntsev', :team => false)
    Packager.create(:name => 'Serge Ryabchun', :email => 'sr@altlinux.org', :login => 'sr', :team => false)
    Packager.create(:name => 'Yurkovsky Andrey', :email => 'anyr@altlinux.org', :login => 'anyr', :team => false)
    Packager.create(:name => 'Mikerin Sergey', :email => 'mikcor@altlinux.org', :login => 'mikcor', :team => false)
    Packager.create(:name => 'Alexey Lokhin', :email => 'warframe@altlinux.org', :login => 'warframe', :team => false)

    # TODO: import teams before import srpm!
    Packager.create(:name => 'TeX Development Team', :email => 'tex@packages.altlinux.org', :login => '@tex', :team => true)
    Packager.create(:name => 'Connexion Development Team', :email => 'connexion@packages.altlinux.org', :login => '@connexion', :team => true)
    Packager.create(:name => 'EVMS Development Team', :email => 'evms@packages.altlinux.org', :login => '@evms', :team => true)
    Packager.create(:name => 'QA Team', :email => 'qa@packages.altlinux.org', :login => '@qa', :team => true)
    Packager.create(:name => 'CPAN Team', :email => 'cpan@packages.altlinux.org', :login => '@cpan', :team => true)

    # who is this?
    Packager.create(:name => 'Unknown', :email => 'vvpi@altlinux.org', :login => 'vvpi', :team => false)

    Packager.update_packager_list 'ALT Linux', 'Sisyphus'
  end
  puts Time.now.to_s + ": end"
end
end
end
