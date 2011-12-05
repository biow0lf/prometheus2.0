# encoding: utf-8

namespace :sisyphus do
  desc 'Update Sisyphus stuff'
  task :update => :environment do
    require 'open-uri'
    puts "#{Time.now.to_s}: Update Sisyphus stuff"
    puts "#{Time.now.to_s}: update *.src.rpm from Sisyphus to database"
    branch = Branch.where(name: 'Sisyphus', vendor: 'ALT Linux').first
    Srpm.import_all(branch, '/ALT/Sisyphus/files/SRPMS/*.src.rpm')
    Srpm.remove_old(branch, '/ALT/Sisyphus/files/SRPMS/')
    puts "#{Time.now.to_s}: end"
    puts "#{Time.now.to_s}: update *.i586.rpm/*.noarch.rpm/*.x86_64.rpm from Sisyphus to database"
    branch = Branch.where(name: 'Sisyphus', vendor: 'ALT Linux').first
    pathes = ['/ALT/Sisyphus/files/i586/RPMS/*.i586.rpm',
              '/ALT/Sisyphus/files/noarch/RPMS/*.noarch.rpm',
              '/ALT/Sisyphus/files/x86_64/RPMS/*.x86_64.rpm']
    Package.import_all(branch, pathes)
    puts "#{Time.now.to_s}: end"
    puts "#{Time.now.to_s}: update repocop cache"
    Repocop.update_repocop_cache
    puts "#{Time.now.to_s}: end"
  end

  # TODO:
  # desc 'Import all ACL for packages from Sisyphus to database'
  # task :acls => :environment do
  #   require 'open-uri'
  #   puts "#{Time.now.to_s}: import all acls for packages from Sisyphus to database"
  #   Acl.import_acls('ALT Linux', 'Sisyphus', 'http://git.altlinux.org/acl/list.packages.t6')
  #   puts "#{Time.now.to_s}: end"
  # end

  desc 'Import *.src.rpm from Sisyphus to database'
  task :srpms => :environment do
    require 'open-uri'
    puts "#{Time.now.to_s}: import *.src.rpm from Sisyphus to database"
    branch = Branch.where(name: 'Sisyphus', vendor: 'ALT Linux').first
    Srpm.import_all(branch, '/ALT/Sisyphus/files/SRPMS/*.src.rpm')
    puts "#{Time.now.to_s}: end"
  end

  desc 'Import *.i586.rpm/*.noarch.rpm/*.x86_64.rpm from Sisyphus to database'
  task :binary => :environment do
    puts "#{Time.now.to_s}: import *.i586.rpm/*.noarch.rpm/*.x86_64.rpm from Sisyphus to database"
    branch = Branch.where(name: 'Sisyphus', vendor: 'ALT Linux').first
    pathes = ['/ALT/Sisyphus/files/i586/RPMS/*.i586.rpm',
              '/ALT/Sisyphus/files/noarch/RPMS/*.noarch.rpm',
              '/ALT/Sisyphus/files/x86_64/RPMS/*.x86_64.rpm']
    Package.import_all(branch, pathes)
    puts "#{Time.now.to_s}: end"
  end

  # desc 'Import all leaders for packages from Sisyphus to database'
  # task :leaders => :environment do
  #   require 'open-uri'
  #   puts "#{Time.now.to_s}: import all leaders for packages from Sisyphus to database"
  #   Leader.import_leaders('ALT Linux', 'Sisyphus', 'http://git.altlinux.org/acl/list.packages.sisyphus')
  #   puts "#{Time.now.to_s}: end"
  # end
  # 
  # desc 'Import all teams from Sisyphus to database'
  # task :teams => :environment do
  #   require 'open-uri'
  #   puts "#{Time.now.to_s}: import all teams from Sisyphus to database"
  #   Team.import_teams('ALT Linux', 'Sisyphus', 'http://git.altlinux.org/acl/list.groups.sisyphus')
  #   puts "#{Time.now.to_s}: end"
  # end
end
