# encoding: utf-8

class Leader < ActiveRecord::Base
  belongs_to :branch
  belongs_to :maintainer
  belongs_to :srpm

  validates :branch, :presence => true
  validates :srpm, :presence => true
  validates :maintainer, :presence => true

  def self.import_leaders(vendor_name, branch_name, url)
    branch = Branch.where(:name => branch_name, :vendor => vendor_name).first
    if branch.leaders.count(:all) == 0
      ActiveRecord::Base.transaction do
        file = open(URI.escape(url)).read
        file.each_line do |line|
          package = line.split[0]
          srpm = Srpm.first :conditions => { :name => package, :branch_id => br.id }
          login = line.split[1]
          login = 'php-coder' if login == 'php_coder'
          login = 'p_solntsev' if login == 'psolntsev'
          login = '@vim-plugins' if login == '@vim_plugins'
          maintainer = Maintainer.where(:login => login).first
          if maintainer.nil?
            puts "#{Time.now.to_s}: maintainer not found '#{login}'"
          elsif srpm.nil?
            puts "#{Time.now.to_s}: srpm not found '#{package}'"
          else
            Leader.create!(:srpm => srpm, :branch => branch, :maintainer => maintainer)
          end
        end
      end
    else
      puts "#{Time.now.to_s}: leaders already imported"
    end
  end

  def self.create_leader_for_package(vendor_name, branch_name, url, package)
    branch = Branch.where(:name => branch_name, :vendor => vendor_name).first
    if branch.srpms.where(:name => package).first.leader != nil
      branch.srpms.where(:name => package).first.leader.delete
    end
    file = open(URI.escape(url)).read
    file.each_line do |line|
      packagename = line.split[0]
      if packagename == package
        srpm = Srpm.where(:name => packagename, :branch => branch).first
        login = line.split[1]
        login = 'php-coder' if login == 'php_coder'
        login = 'p_solntsev' if login == 'psolntsev'
        login = '@vim-plugins' if login == '@vim_plugins'
        maintainer = Maintainer.where(:login => login).first
        if maintainer.nil?
          puts "#{Time.now.to_s}: maintainer not found '#{login}'"
        else
          Leader.create!(:srpm => srpm, :branch => branch, :maintainer => maintainer)
        end
      end
    end
  end
end
