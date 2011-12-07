# encoding: utf-8

namespace :sisyphusarm do
  desc 'Update SisyphusARM stuff'
  task :update => :environment do
    require 'open-uri'
    puts "#{Time.now.to_s}: Update SisyphusARM stuff"
    puts "#{Time.now.to_s}: update *.src.rpm from SisyphusARM to database"
    branch = Branch.where(name: 'SisyphusARM', vendor: 'ALT Linux').first
    Srpm.import_all(branch, '/ALT/Sisyphus/arm/SRPMS.all/*.src.rpm')
    Srpm.remove_old(branch, '/ALT/Sisyphus/arm/SRPMS.all/')
    puts "#{Time.now.to_s}: end"
    puts "#{Time.now.to_s}: update *.arm.rpm/*.noarch.rpm from SisyphusARM to database"
    pathes = ['/ALT/Sisyphus/files/arm/RPMS/*.rpm']
    Package.import_all(branch, pathes)
    puts "#{Time.now.to_s}: end"
  end

  desc 'Import *.src.rpm from SisyphusARM to database'
  task :srpms => :environment do
    require 'open-uri'
    puts "#{Time.now.to_s}: import *.src.rpm from SisyphusARM to database"
    branch = Branch.where(name: 'SisyphusARM', vendor: 'ALT Linux').first
    Srpm.import_all(branch, '/ALT/Sisyphus/arm/SRPMS.all/*.src.rpm')
    puts "#{Time.now.to_s}: end"
  end

  desc 'Import *.arm.rpm/*.noarch.rpm from SisyphusARM to database'
  task :binary => :environment do
    require 'open-uri'
    puts "#{Time.now.to_s}: import *.arm.rpm/*.noarch.rpm from SisyphusARM to database"
    branch = Branch.where(name: 'SisyphusARM', vendor: 'ALT Linux').first
    pathes = ['/ALT/Sisyphus/files/arm/RPMS/*.rpm']
    Package.import_all(branch, pathes)
    puts "#{Time.now.to_s}: end"
  end
end
