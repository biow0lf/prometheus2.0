# encoding: utf-8

namespace :t6 do
  desc 'Update t6 stuff'
  task :update => :environment do
    require 'open-uri'
    puts "#{Time.now.to_s}: Update t6 stuff"
    puts "#{Time.now.to_s}: update *.src.rpm from t6 to database"
    branch = Branch.where(name: 't6', vendor: 'ALT Linux').first
    Srpm.import_all(branch, '/ALT/t6/files/SRPMS/*.src.rpm')
    Srpm.remove_old(branch, '/ALT/t6/files/SRPMS/')
    puts "#{Time.now.to_s}: end"
    puts "#{Time.now.to_s}: update *.i586.rpm/*.noarch.rpm/*.x86_64.rpm from t6 to database"
    pathes = ['/ALT/t6/files/i586/RPMS/*.i586.rpm',
              '/ALT/t6/files/noarch/RPMS/*.noarch.rpm',
              '/ALT/t6/files/x86_64/RPMS/*.x86_64.rpm']
    Package.import_all(branch, pathes)
    puts "#{Time.now.to_s}: end"
  end

  desc 'Import *.src.rpm from t6 to database'
  task :srpms => :environment do
    require 'open-uri'
    puts "#{Time.now.to_s}: import *.src.rpm from t6 to database"
    branch = Branch.where(name: 't6', vendor: 'ALT Linux').first
    Srpm.import_all(branch, '/ALT/t6/files/SRPMS/*.src.rpm')
    puts "#{Time.now.to_s}: end"
  end

  desc 'Import *.i586.rpm/*.noarch.rpm/*.x86_64.rpm from t6 to database'
  task :binary => :environment do
    require 'open-uri'
    puts "#{Time.now.to_s}: import *.i586.rpm/*.noarch.rpm/*.x86_64.rpm from t6 to database"
    branch = Branch.where(name: 't6', vendor: 'ALT Linux').first
    pathes = ['/ALT/t6/files/i586/RPMS/*.i586.rpm',
              '/ALT/t6/files/noarch/RPMS/*.noarch.rpm',
              '/ALT/t6/files/x86_64/RPMS/*.x86_64.rpm']
    Package.import_all(branch, pathes)
    puts "#{Time.now.to_s}: end"
  end
end
