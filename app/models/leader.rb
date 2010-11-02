class Leader < ActiveRecord::Base
  belongs_to :branch
  belongs_to :maintainer
  belongs_to :srpm

  def self.import_leaders(vendor, branch, url)
    br = Branch.first :conditions => { :name => branch, :vendor => vendor }
    if br.leaders.count(:all) == 0
      ActiveRecord::Base.transaction do
        file = open(URI.escape(url)).read
        file.each_line do |line|
          package = line.split[0]
          srpm = Srpm.first :conditions => { :name => package, :branch_id => br.id }
          login = line.split[1]
          login = 'php-coder' if login == 'php_coder'
          login = 'p_solntsev' if login == 'psolntsev'
          login = '@vim-plugins' if login == '@vim_plugins'
          maintainer = Maintainer.first :conditions => { :login => login }
          if maintainer.nil?
            puts Time.now.to_s + ": maintainer not found '" + login + "'"
          elsif srpm.nil?
            puts Time.now.to_s + ": srpm not found '" + package + "'"
          else
            Leader.create :srpm_id => srpm.id, :branch_id => br.id, :maintainer_id => maintainer.id
          end
        end
      end
    else
      puts Time.now.to_s + ": leaders already imported"
    end
  end
  
  def self.create_leader_for_package(vendor, branch, url, package)
    br = Branch.first :conditions => { :name => branch, :vendor => vendor }
    if br.srpms.where(:name => package).first.leader != nil
      br.srpms.where(:name => package).first.leader.delete
    end
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
          Leader.create :srpm_id => srpm.id, :branch_id => br.id, :maintainer_id => maintainer.id
        end
      end
    end
  end
end