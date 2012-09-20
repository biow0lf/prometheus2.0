# encoding: utf-8

namespace :migrate do
  desc 'Import all patches and sources to database'
  task :import_patches_and_sources => :environment do

    branch = Branch.where(name: 'Sisyphus').first
    branch.srpms.find_each do |srpm|
      file = "/ALT/Sisyphus/files/SRPMS/#{srpm.filename}"
      if File.exists?(file)
        puts "Import from #{srpm.filename}"
        Patch.import(branch, file, srpm)
        Source.import(branch, file, srpm)
      else
        puts "Skip #{srpm.filename}"
      end
    end

  end
end

