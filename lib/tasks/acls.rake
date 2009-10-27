require 'open-uri'

namespace :sisyphus do
desc "Import all ACL for packages from Sisyphus to database"
task :acls => :environment do
  puts "import acls"
  puts Time.now

  Acl.transaction do
    Acl.delete_all

    branch = Branch.find :first, :conditions => { :urlname => 'Sisyphus'}

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
        srpm = Srpm.find :first, :conditions => { :branch_id => branch.id, :name => package }
#        puts login
#        puts package
#        puts packager
#        puts srpm

        #if packager[0] != '@'
        #FIXME
        if packager != nil
          if srpm != nil
            Acl.create :package => package, :login => login, :packager_id => packager.id, :srpm_id => srpm.id, :branch_id => branch.id
          end
        else
          if srpm != nil
            puts login
            puts package
            puts packager
            puts srpm
            Acl.create :package => package, :login => login, :srpm_id => srpm.id, :branch_id => branch.id
          end
          #FIXME
        end
#        Acl.create(:package => package, :login => login, :branch => 'Sisyphus')
      end
    end
  end

  puts Time.now
end
end
