class Acl < ActiveRecord::Base
  belongs_to :branch
  belongs_to :maintainer
  belongs_to :srpm

  def self.import_acls(vendor, branch, url)
    br = Branch.first :conditions => { :name => branch, :vendor => vendor }
    if br.acls.count(:all) == 0
      ActiveRecord::Base.transaction do
        file = open(URI.escape(url)).read
        file.each_line do |line|
          package = line.split[0]
          for i in 1..line.split.count-1
            login = line.split[i]
            login = 'php-coder' if login == 'php_coder'
            login = 'p_solntsev' if login == 'psolntsev'
            login = '@vim-plugins' if login == '@vim_plugins'

            maintainer = Maintainer.first :conditions => { :login => login }
            srpm = Srpm.first :conditions => { :branch_id => br.id, :name => package }

            if maintainer.nil?
              puts Time.now.to_s + ": maintainer not found '" + login + "'"
            elsif srpm.nil?
              puts Time.now.to_s + ": srpm not found '" + package + "'"
            else
              Acl.create :srpm_id => srpm.id, :maintainer_id => maintainer.id, :branch_id => br.id
            end
          end
        end
      end
    else
      puts Time.now.to_s + ": acls already imported"
    end
  end

  def self.create_acls_for_package(vendor, branch, url, package)
    br = Branch.first :conditions => { :name => branch, :vendor => vendor }
    br.srpms.where(:name => package).first.acls.delete_all
    file = open(URI.escape(url)).read
    file.each_line do |line|
      packagename = line.split[0]
      if packagename == package
        srpm = Srpm.first :conditions => { :name => packagename, :branch_id => br.id }
        login = line.split[1]
        login = 'php-coder' if login == 'php_coder'
        login = 'p_solntsev' if login == 'psolntsev'
        login = '@vim-plugins' if login == '@vim_plugins'
        maintainer = Maintainer.first :conditions => { :login => login }
        if maintainer.nil?
          puts Time.now.to_s + ": maintainer not found '" + login + "'"
        else
          Acl.create :srpm_id => srpm.id, :maintainer_id => maintainer.id, :branch_id => br.id
        end
      end
    end
  end
end