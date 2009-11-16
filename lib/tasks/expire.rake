namespace :sisyphus do
namespace :expire do

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

end
end