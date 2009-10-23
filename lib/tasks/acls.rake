require 'open-uri'

namespace :sisyphus do
desc "Import all ACL for packages from Sisyphus to database"
task :acls => :environment do
  puts "import acls"
  puts Time.now

  Acl.transaction do
    Acl.delete_all

    url = "http://git.altlinux.org/acl/list.packages.sisyphus"
    f = open(URI.escape(url)).read

    f.each_line do |line|
      package = line.split[0]
      #(1..line.split.count).each do |i|
      for i in 1..line.split.count-1
        login = line.split[i]
        login = 'php-coder' if login == 'php_coder'
        login = '@vim-plugins' if login == '@vim_plugins'
        login = 'p_solntsev' if login == 'psolntsev'

        packager = Packager.find :first, :conditions => { :login => login }
        srpm = Srpm.find :first, :conditions => { :branch => 'Sisyphus', :name => package }
#        puts login
#        puts package
#        puts packager
#        puts srpm

        #if packager[0] != '@'
        #FIXME
        if packager != nil
          if srpm != nil
            Acl.create :package => package, :login => login, :packager_id => packager.id, :srpm_id => srpm.id, :branch => 'Sisyphus'
          end
        else
          if srpm != nil
            puts login
            puts package
            puts packager
            puts srpm
            Acl.create :package => package, :login => login, :srpm_id => srpm.id, :branch => 'Sisyphus'
          end
          #FIXME
        end
#        Acl.create(:package => package, :login => login, :branch => 'Sisyphus')
      end
    end
  end

#Packager.all.each do |packager|
#  acls = Acl.find :all, :conditions => { :login => packager.login, :branch => 'Sisyphus' }
#  if acls != nil
#    acls.each do |acl|
#    acl.packager_id = packager.id
#    acl.save!
#  end
#end

#Acl.all.each do |acl|
#  srpm = Srpm.find :first, :conditions => { :branch => acl.branch, :name => acl.package }
#  if srpm != nil
#    acl.srpm_id = srpm.id
#    acl.save!
#  end
#end


  puts Time.now
end
end
