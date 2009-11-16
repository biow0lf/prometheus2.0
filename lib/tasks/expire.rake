namespace :sisyphus do
namespace :expire do

desc "Expire all page which are use ACL"
task :acls => :environment do
  puts "Expire all page which are use ACL"
  puts Time.now

  ActionController::Base.expire_page('/')
  ActionController::Base.expire_page('/en')
  ActionController::Base.expire_page('/ru')
  ActionController::Base.expire_page('/ru/people')
  ActionController::Base.expire_page('/en/people')
  ActionController::Base.expire_page('/people')

  packagers = Packager.find :all, :conditions => { :team => false }

  packagers.each do |packager|
    ActionController::Base.expire_page('/ru/packager/' + packager.login)
    ActionController::Base.expire_page('/en/packager/' + packager.login)
    ActionController::Base.expire_page('/packager/' + packager.login)
    ActionController::Base.expire_page('/ru/packager/' + packager.login + '/srpms')
    ActionController::Base.expire_page('/en/packager/' + packager.login + '/srpms')
    ActionController::Base.expire_page('/packager/' + packager.login + '/srpms')
  end

  teams = Packager.find :all, :conditions => { :team => true }

  teams.each do |team|
    ActionController::Base.expire_page('/ru/team/' + team.login[1..-1])
    ActionController::Base.expire_page('/en/team/' + team.login[1..-1])
    ActionController::Base.expire_page('/team/' + team.login[1..-1])
  end

  branch = Branch.find :first, :conditions => { :urlname => 'Sisyphus' }
  srpms = Srpm.find :all, :conditions => { :branch_id => branch.id }, :select => 'name'
  srpms.each do |srpm|
    ActionController::Base.expire_page('/ru/srpm/Sisyphus/' + srpm.name)
    ActionController::Base.expire_page('/en/srpm/Sisyphus/' + srpm.name)
    ActionController::Base.expire_page('/srpm/Sisyphus/' + srpm.name)
  end

  puts Time.now
end

desc "Expire cache for /*/srpm/Sisyphus/*"
task :srpm => :environment do
  puts Time.now
  puts "Expire cache for /*/srpm/Sisyphus/*"

  branch = Branch.find :first, :conditions => { :urlname => 'Sisyphus' }

  srpms = Srpm.find :all, :conditions => { :branch_id => branch.id }, :select => 'name'

  srpms.each do |srpm|
    ActionController::Base.expire_page('/ru/srpm/Sisyphus/' + srpm.name)
    ActionController::Base.expire_page('/en/srpm/Sisyphus/' + srpm.name)
    ActionController::Base.expire_page('/srpm/Sisyphus/' + srpm.name)
  end

  puts Time.now
end

desc "Expire cache for /*/srpm/Sisyphus/*/changelog"
task :changelog => :environment do
  puts Time.now
  puts "Expire cache for /*/srpm/Sisyphus/*/changelog"

  branch = Branch.find :first, :conditions => { :urlname => 'Sisyphus' }

  srpms = Srpm.find :all, :conditions => { :branch_id => branch.id }, :select => 'name'

  srpms.each do |srpm|
    ActionController::Base.expire_page('/ru/srpm/Sisyphus/' + srpm.name + '/changelog')
    ActionController::Base.expire_page('/en/srpm/Sisyphus/' + srpm.name + '/changelog')
    ActionController::Base.expire_page('/srpm/Sisyphus/' + srpm.name + '/changelog')
  end

  puts Time.now
end


desc "Expire cache for /*/srpm/Sisyphus/*/spec"
task :spec => :environment do
  puts Time.now
  puts "Expire cache for /*/srpm/Sisyphus/*/spec"

  branch = Branch.find :first, :conditions => { :urlname => 'Sisyphus' }

  srpms = Srpm.find :all, :conditions => { :branch_id => branch.id }, :select => 'name'

  srpms.each do |srpm|
    ActionController::Base.expire_page('/ru/srpm/Sisyphus/' + srpm.name + '/spec')
    ActionController::Base.expire_page('/en/srpm/Sisyphus/' + srpm.name + '/spec')
    ActionController::Base.expire_page('/srpm/Sisyphus/' + srpm.name + '/spec')
  end

  puts Time.now
end


desc "Expire cache for /*/srpm/Sisyphus/*/patches"
task :patches => :environment do
  puts Time.now
  puts "Expire cache for /*/srpm/Sisyphus/*/patches"

  branch = Branch.find :first, :conditions => { :urlname => 'Sisyphus' }

  srpms = Srpm.find :all, :conditions => { :branch_id => branch.id }, :select => 'name'

  srpms.each do |srpm|
    ActionController::Base.expire_page('/ru/srpm/Sisyphus/' + srpm.name + '/patches')
    ActionController::Base.expire_page('/en/srpm/Sisyphus/' + srpm.name + '/patches')
    ActionController::Base.expire_page('/srpm/Sisyphus/' + srpm.name + '/patches')
  end

  puts Time.now
end

desc "Expire cache for /*/srpm/Sisyphus/*/sources"
task :sources => :environment do
  puts Time.now
  puts "Expire cache for /*/srpm/Sisyphus/*/sources"

  branch = Branch.find :first, :conditions => { :urlname => 'Sisyphus' }

  srpms = Srpm.find :all, :conditions => { :branch_id => branch.id }, :select => 'name'

  srpms.each do |srpm|
    ActionController::Base.expire_page('/ru/srpm/Sisyphus/' + srpm.name + '/sources')
    ActionController::Base.expire_page('/en/srpm/Sisyphus/' + srpm.name + '/sources')
    ActionController::Base.expire_page('/srpm/Sisyphus/' + srpm.name + '/sources')
  end

  puts Time.now
end

desc "Expire cache for /*/srpm/Sisyphus/*/get"
task :download => :environment do
  puts Time.now
  puts "Expire cache for /*/srpm/Sisyphus/*/get"

  branch = Branch.find :first, :conditions => { :urlname => 'Sisyphus' }

  srpms = Srpm.find :all, :conditions => { :branch_id => branch.id }, :select => 'name'

  srpms.each do |srpm|
    ActionController::Base.expire_page('/ru/srpm/Sisyphus/' + srpm.name + '/get')
    ActionController::Base.expire_page('/en/srpm/Sisyphus/' + srpm.name + '/get')
    ActionController::Base.expire_page('/srpm/Sisyphus/' + srpm.name + '/get')
  end

  puts Time.now
end

desc "Expire cache for /*/srpm/Sisyphus/*/gear"
task :gear => :environment do
  puts Time.now
  puts "Expire cache for /*/srpm/Sisyphus/*/gear"

  branch = Branch.find :first, :conditions => { :urlname => 'Sisyphus' }

  srpms = Srpm.find :all, :conditions => { :branch_id => branch.id }, :select => 'name'

  srpms.each do |srpm|
    ActionController::Base.expire_page('/ru/srpm/Sisyphus/' + srpm.name + '/gear')
    ActionController::Base.expire_page('/en/srpm/Sisyphus/' + srpm.name + '/gear')
    ActionController::Base.expire_page('/srpm/Sisyphus/' + srpm.name + '/gear')
  end

  puts Time.now
end

desc "Expire cache for /*/srpm/Sisyphus/*/bugs"
task :bugs => :environment do
  puts Time.now
  puts "Expire cache for /*/srpm/Sisyphus/*/bugs"

  branch = Branch.find :first, :conditions => { :urlname => 'Sisyphus' }

  srpms = Srpm.find :all, :conditions => { :branch_id => branch.id }, :select => 'name'

  srpms.each do |srpm|
    ActionController::Base.expire_page('/ru/srpm/Sisyphus/' + srpm.name + '/bugs')
    ActionController::Base.expire_page('/en/srpm/Sisyphus/' + srpm.name + '/bugs')
    ActionController::Base.expire_page('/srpm/Sisyphus/' + srpm.name + '/bugs')
    ActionController::Base.expire_page('/ru/srpm/Sisyphus/' + srpm.name + '/allbugs')
    ActionController::Base.expire_page('/en/srpm/Sisyphus/' + srpm.name + '/allbugs')
    ActionController::Base.expire_page('/srpm/Sisyphus/' + srpm.name + '/allbugs')
  end

  puts Time.now
end


desc "Expire cache for /*/srpm/Sisyphus/*/repocop"
task :repocop => :environment do
  puts Time.now
  puts "Expire cache for /*/srpm/Sisyphus/*/repocop"

  branch = Branch.find :first, :conditions => { :urlname => 'Sisyphus' }

  srpms = Srpm.find :all, :conditions => { :branch_id => branch.id }, :select => 'name'

  srpms.each do |srpm|
    ActionController::Base.expire_page('/ru/srpm/Sisyphus/' + srpm.name + '/repocop')
    ActionController::Base.expire_page('/en/srpm/Sisyphus/' + srpm.name + '/repocop')
    ActionController::Base.expire_page('/srpm/Sisyphus/' + srpm.name + '/repocop')
  end

  puts Time.now
end

desc "Expire cache for /*/packages"
task :groups => :environment do
  puts Time.now
  puts "Expire cache for /*/packages"

  ActionController::Base.expire_page('/ru/packages')
  ActionController::Base.expire_page('/en/packages')
  ActionController::Base.expire_page('/packages')

  puts Time.now
end


end
end
