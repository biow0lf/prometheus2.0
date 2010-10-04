class Gitrepo < ActiveRecord::Base
  validates_presence_of :repo, :lastchange
  belongs_to :maintainer
  
  def self.import_gitrepos(url)
    if Gitrepo.count(:all) == 0
      branch = Branch.first :conditions => { :name => 'Sisyphus', :vendor => 'ALT Linux' }
      ActiveRecord::Base.transaction do
        file = open(URI.escape(url)).read

        file.each_line do |line|
          gitrepo = line.split[0]
          login = gitrepo.split('/')[2]
          login = 'php-coder' if login == 'php_coder'
          login = 'p_solntsev' if login == 'psolntsev'
          package = gitrepo.split('/')[4]
          time = Time.at(line.split[1].to_i)
          
          maintainer = Maintainer.first :conditions => { :login => login }
          srpm = Srpm.first :conditions => { :name => package.gsub(/\.git/,''), :branch_id => branch.id }
          
          if maintainer.nil?
            puts Time.now.to_s + ": maintainer not found '" + login + "'"
          elsif srpm.nil?
            puts Time.now.to_s + ": srpm not found '" + package.gsub(/\.git/,'') + "'"
          else
            Gitrepo.create(:repo => package.gsub(/\.git/,''), :maintainer_id => maintainer.id, :lastchange => time, :srpm_id => srpm.id)
          end
        end
      end    
    else
      puts Time.now.to_s + ": gitrepos already imported"
    end
  end
end