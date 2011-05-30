class Gitrepo < ActiveRecord::Base
  validates :repo, :presence => true
  validates :lastchange, :presence => true

  belongs_to :maintainer
  belongs_to :srpm

  def self.update_gitrepos(url)
    ActiveRecord::Base.transaction do
      Gitrepo.delete_all
      Gitrepo.import_gitrepos(url)
    end
  end

  def self.import_gitrepos(url)
    if Gitrepo.count(:all) == 0
      branch = Branch.where(:name => 'Sisyphus', :vendor => 'ALT Linux').first
      file = open(URI.escape(url)).read
      file.each_line do |line|
        gitrepo = line.split[0]
        login = gitrepo.split('/')[2]
        login = 'php-coder' if login == 'php_coder'
        login = 'p_solntsev' if login == 'psolntsev'
        package = gitrepo.split('/')[4]
        time = Time.at(line.split[1].to_i)

        maintainer = Maintainer.where(:login => login).first
        srpm = Srpm.where(:name => package.gsub(/\.git/,''), :branch => branch).first

        if maintainer.nil?
          puts "#{Time.now.to_s}: maintainer not found '#{login}'"
        elsif srpm.nil?
          puts "#{Time.now.to_s}: srpm not found '#{package.gsub(/\.git/,'')}'"
        else
          Gitrepo.create(:repo => package.gsub(/\.git/,''), :maintainer => maintainer, :lastchange => time, :srpm => srpm)
        end
      end
    else
      puts "#{Time.now.to_s}: gitrepos already imported"
    end
  end
end
