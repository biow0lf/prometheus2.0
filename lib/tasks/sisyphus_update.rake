namespace :sisyphus do
  namespace :update do
    desc "Update *.src.rpm from Sisyphus to database"
    task :srpms => :environment do
      require 'rpm'
      require 'open-uri'
      puts Time.now.to_s + ": update *.src.rpm from Sisyphus to database"
      ActiveRecord::Base.transaction do
        ActiveRecord::Base.connection.execute("DELETE FROM srpms WHERE branch = 'Sisyphus' AND vendor = 'ALT Linux'")
        Srpm.import_srpms 'ALT Linux', 'Sisyphus', "/ALT/Sisyphus/files/SRPMS/*.src.rpm"
        Repocop.update_repocop_cache
      end
      puts Time.now.to_s + ": end"
    end

    desc "Update *.i586.rpm from Sisyphus to database"
    task :i586 => :environment do
      require 'rpm'
      puts Time.now.to_s + ": update *.i586.rpm from Sisyphus to database"
      ActiveRecord::Base.transaction do
        ActiveRecord::Base.connection.execute("DELETE FROM packages WHERE arch = 'i586' AND branch = 'Sisyphus' AND vendor = 'ALT Linux'")
        Package.import_packages_i586 'ALT Linux', 'Sisyphus', "/ALT/Sisyphus/files/i586/RPMS/*.i586.rpm"
      end
      puts Time.now.to_s + ": end"
    end

    desc "Update *.noarch.rpm from Sisyphus to database"
    task :noarch => :environment do
      require 'rpm'
      puts Time.now.to_s + ": update *.noarch.rpm from Sisyphus to database"
      ActiveRecord::Base.transaction do
        ActiveRecord::Base.connection.execute("DELETE FROM packages WHERE arch = 'noarch' AND branch = 'Sisyphus' AND vendor = 'ALT Linux'")
        Package.import_packages_noarch 'ALT Linux', 'Sisyphus', "/ALT/Sisyphus/files/noarch/RPMS/*.noarch.rpm"
      end
      puts Time.now.to_s + ": end"
    end

    desc "Update *.x86_64.rpm from Sisyphus to database"
    task :x86_64 => :environment do
      require 'rpm'
      puts Time.now.to_s + ": update *.x86_64.rpm from Sisyphus to database"
      ActiveRecord::Base.transaction do
        ActiveRecord::Base.connection.execute("DELETE FROM packages WHERE arch = 'x86_64' AND branch = 'Sisyphus' AND vendor = 'ALT Linux'")
        Package.import_packages_x86_64 'ALT Linux', 'Sisyphus', "/ALT/Sisyphus/files/x86_64/RPMS/*.x86_64.rpm"
      end
      puts Time.now.to_s + ": end"
    end

#    desc "Update maintainers list from Sisyphus to database"
#    task :maintainers => :environment do
#      require 'rpm'
#      puts Time.now.to_s + ": update maintainers list from Sisyphus to database"
#      ActiveRecord::Base.transaction do
#        Maintainer.delete_all
#
#        Maintainer.create(:name => 'Nobody', :email => 'noboby@altlinux.org', :login => '@nobody', :team => true)
#
#        Maintainer.create(:name => 'Igor Zubkov', :email => 'icesik@altlinux.org', :login => 'icesik', :team => false)
#        Maintainer.create(:name => 'Alexey Tourbin', :email => 'at@altlinux.org', :login => 'at', :team => false)
#        Maintainer.create(:name => 'Alexey I. Froloff', :email => 'raorn@altlinux.org', :login => 'raorn', :team => false)
#        Maintainer.create(:name => 'Eugeny A. Rostovtsev', :email => 'real@altlinux.org', :login => 'real', :team => false)
#        Maintainer.create(:name => 'Alexey Rusakov', :email => 'ktirf@altlinux.org', :login => 'ktirf', :team => false)
#        Maintainer.create(:name => 'Alex Gorbachenko', :email => 'algor@altlinux.org', :login => 'algor', :team => false)
#        Maintainer.create(:name => 'Andriy Stepanov', :email => 'stanv@altlinux.org', :login => 'stanv', :team => false)
#        Maintainer.create(:name => 'Anton Farygin', :email => 'rider@altlinux.org', :login => 'rider', :team => false)
#        Maintainer.create(:name => 'Igor Muratov', :email => 'migor@altlinux.org', :login => 'migor', :team => false)
#        Maintainer.create(:name => 'Mihail A. Pluzhnikov', :email => 'amike@altlinux.org', :login => 'amike', :team => false)
#        Maintainer.create(:name => 'Pavel V. Solntsev', :email => 'p_solntsev@altlinux.org', :login => 'p_solntsev', :team => false)
#        Maintainer.create(:name => 'Serge Ryabchun', :email => 'sr@altlinux.org', :login => 'sr', :team => false)
#        Maintainer.create(:name => 'Yurkovsky Andrey', :email => 'anyr@altlinux.org', :login => 'anyr', :team => false)
#        Maintainer.create(:name => 'Mikerin Sergey', :email => 'mikcor@altlinux.org', :login => 'mikcor', :team => false)
#        Maintainer.create(:name => 'Alexey Lokhin', :email => 'warframe@altlinux.org', :login => 'warframe', :team => false)
#        Maintainer.create(:name => 'Alexey Shabalin', :email => 'shaba@altlinux.org', :login => 'shaba', :team => false)
#        Maintainer.create(:name => 'Valery Pipin', :email => 'vvpi@altlinux.org', :login => 'vvpi', :team => false)
#        Maintainer.create(:name => 'Pavel Boldin', :email => 'bp@altlinux.org', :login => 'bp', :team => false)
#        Maintainer.create(:name => 'Ruslan Hihin', :email => 'ruslandh@altlinux.org', :login => 'ruslandh', :team => false)
#        Maintainer.create(:name => 'Sergey Lebedev', :email => 'barabashka@altlinux.org', :login => 'barabashka', :team => false)
#        Maintainer.create(:name => 'Konstantin Pavlov', :email => 'thresh@altlinux.org', :login => 'thresh', :team => false)
#
#        # TODO: import teams before import srpm!
#        Maintainer.create(:name => 'TeX Development Team', :email => 'tex@packages.altlinux.org', :login => '@tex', :team => true)
#        Maintainer.create(:name => 'Connexion Development Team', :email => 'connexion@packages.altlinux.org', :login => '@connexion', :team => true)
#        Maintainer.create(:name => 'EVMS Development Team', :email => 'evms@packages.altlinux.org', :login => '@evms', :team => true)
#        Maintainer.create(:name => 'QA Team', :email => 'qa@packages.altlinux.org', :login => '@qa', :team => true)
#        Maintainer.create(:name => 'CPAN Team', :email => 'cpan@packages.altlinux.org', :login => '@cpan', :team => true)
#
#        Maintainer.update_maintainer_list 'ALT Linux', 'Sisyphus', "/ALT/Sisyphus/files/SRPMS/*.src.rpm"
#      end
#      puts Time.now.to_s + ": end"
#    end
  end
end