namespace :sisyphus do
  desc "Import all ACL for packages from Sisyphus to database"
  task :acls => :environment do
    require 'open-uri'
    puts Time.now.to_s + ": import all acls for packages from Sisyphus to database"
    Acl.import_acls 'ALT Linux', 'Sisyphus', 'http://git.altlinux.org/acl/list.packages.sisyphus'
    puts Time.now.to_s + ": end"
  end

  desc "Import RPM groups for Sisyphus to database"
  task :groups => :environment do
    require 'open-uri'
    puts Time.now.to_s + ": import RPM groups for Sisyphus to database"
    Group.import_groups 'ALT Linux', 'Sisyphus', 'http://git.altlinux.org/gears/r/rpm.git?p=rpm.git;a=blob_plain;f=GROUPS'
    puts Time.now.to_s + ": end"
  end

  desc "Import *.src.rpm from Sisyphus to database"
  task :srpms => :environment do
    require 'rpm'
    require 'open-uri'
    puts Time.now.to_s + ": import *.src.rpm from Sisyphus to database"
    Srpm.import_srpms 'ALT Linux', 'Sisyphus', "/ALT/Sisyphus/files/SRPMS/*.src.rpm"
    puts Time.now.to_s + ": end"
    puts Time.now.to_s + ': update repocop cache'
    Repocop.update_repocop_cache  
    puts Time.now.to_s + ': end'
  end

  desc "Import *.i586.rpm from Sisyphus to database"
  task :i586 => :environment do
    require 'rpm'
    puts Time.now.to_s + ": import *.i586.rpm from Sisyphus to database"
    Package.import_packages_i586 'ALT Linux', 'Sisyphus', "/ALT/Sisyphus/files/i586/RPMS/*.i586.rpm"
    puts Time.now.to_s + ": end"
  end

  desc "Import *.noarch.rpm from Sisyphus to database"
  task :noarch => :environment do
    require 'rpm'
    puts Time.now.to_s + ": import *.noarch.rpm from Sisyphus to database"
    Package.import_packages_noarch 'ALT Linux', 'Sisyphus', "/ALT/Sisyphus/files/noarch/RPMS/*.noarch.rpm"
    puts Time.now.to_s + ": end"
  end

  desc "Import *.x86_64.rpm from Sisyphus to database"
  task :x86_64 => :environment do
    require 'rpm'
    puts Time.now.to_s + ": import *.x86_64.rpm from Sisyphus to database"
    Package.import_packages_x86_64 'ALT Linux', 'Sisyphus', "/ALT/Sisyphus/files/x86_64/RPMS/*.x86_64.rpm"
    puts Time.now.to_s + ": end"
  end

  desc "Import all leaders for packages from Sisyphus to database"
  task :leaders => :environment do
    require 'open-uri'
    puts Time.now.to_s + ": import all leaders for packages from Sisyphus to database"
    Leader.import_leaders 'ALT Linux', 'Sisyphus', 'http://git.altlinux.org/acl/list.packages.sisyphus'
    puts Time.now.to_s + ": end"
  end

  desc "Import maintainers list from src.rpm from Sisyphus to database"
  task :maintainers => :environment do
    require 'rpm'
    puts Time.now.to_s + ": import packagers list from *.src.rpm's"
    Maintainer.import_maintainers_list "/ALT/Sisyphus/files/SRPMS/*.src.rpm"
    puts Time.now.to_s + ": end"
  end

  desc "Import all teams from Sisyphus to database"
  task :teams => :environment do
    require 'open-uri'
    puts Time.now.to_s + ": import all teams from Sisyphus to database"
    Team.import_teams 'ALT Linux', 'Sisyphus', 'http://git.altlinux.org/acl/list.groups.sisyphus'
    puts Time.now.to_s + ": end"
  end
end