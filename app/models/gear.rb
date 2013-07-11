class Gear < ActiveRecord::Base
  belongs_to :maintainer
  belongs_to :srpm

  validates :repo, presence: true
  validates :lastchange, presence: true

  def self.update_gitrepos(url)
    ActiveRecord::Base.transaction do
      Gear.delete_all
      Gear.import_gitrepos(url)
    end
  end

  def self.import_gitrepos(url)
    branch = Branch.where(name: 'Sisyphus', vendor: 'ALT Linux').first
    file = open(URI::Parser.new.escape(url)).read
    file.each_line do |line|
      gitrepo = line.split[0]
      login = gitrepo.split('/')[2]
      login = 'php-coder'  if login == 'php_coder'
      login = 'p_solntsev' if login == 'psolntsev'
      package = gitrepo.split('/')[4]
      time = Time.at(line.split[1].to_i)

      maintainer = Maintainer.where(login: login).first
      srpm = Srpm.where(name: package.gsub(/\.git/,''), branch_id: branch).first

      if maintainer.nil?
        Rails.logger.info("#{Time.now.to_s}: maintainer not found '#{login}'")
      elsif srpm.nil?
#        Rails.logger.info("#{Time.now.to_s}: srpm not found '#{package.gsub(/\.git/,'')}'")
      else
        Gear.create!(repo: package.gsub(/\.git/,''), maintainer: maintainer, lastchange: time, srpm: srpm)
      end
    end
  end
end
