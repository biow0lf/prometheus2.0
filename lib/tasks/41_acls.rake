require 'open-uri'

namespace :"41" do
desc "Import all ACL for packages from 4.1 to database"
task :acls => :environment do
  puts "import acls"
  puts Time.now

  ActiveRecord::Base.transaction do
    branch = Branch.find :first, :conditions => { :urlname => '4.1' }
    ActiveRecord::Base.connection.execute("DELETE FROM acls WHERE branch_id = " + branch.id.to_s)

    url = "http://git.altlinux.org/acl/list.packages.4.1"
    file = open(URI.escape(url)).read

    file.each_line do |line|
      package = line.split[0]
      for i in 1..line.split.count-1
        login = line.split[i]
        login = 'php-coder' if login == 'php_coder'
        login = '@vim-plugins' if login == '@vim_plugins'
        login = 'p_solntsev' if login == 'psolntsev'

        packager = Packager.find :first, :conditions => { :login => login }, :select => 'id'
        srpm = Srpm.find :first, :conditions => { :branch => branch.urlname, :name => package }, :select => 'id'

        if packager != nil
          if srpm != nil
            Acl.create :package => package, :login => login, :packager_id => packager.id, :srpm_id => srpm.id, :branch_id => branch.id
          end
        else
          # this code only for one case
          # if ACL for Packager A exists for Package B, but Packager A doesn't update any package
          if srpm != nil
            Acl.create :package => package, :login => login, :srpm_id => srpm.id, :branch_id => branch.id
          end
        end
      end
    end
  end

  puts Time.now
end
end
