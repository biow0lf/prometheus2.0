class Maintainer < ActiveRecord::Base
  validates :name, :presence => true
  validates :email, :presence => true
  validates :login, :presence => true, :uniqueness => true

  has_one :leader
  has_many :acls
  has_many :teams
  has_many :srpms, :through => :acls
  has_many :gitrepos

  def self.import_maintainers_list(path)
    Dir.glob(path).each do |file|
      begin
        rpm = RPM::Package::open(file)
        maintainer = rpm[1015]
        maintainer_name = maintainer.split('<')[0].chomp
        maintainer_name.strip!
        maintainer_email = maintainer.chop.split('<')[1]

        maintainer_email.downcase!

        maintainer_email.gsub!(' at altlinux.ru', '@altlinux.org')
        maintainer_email.gsub!(' at altlinux.org', '@altlinux.org')
        maintainer_email.gsub!(' at altlinux.net', '@altlinux.org')
        maintainer_email.gsub!(' at altlinux.com', '@altlinux.org')
        maintainer_email.gsub!(' at altlinux dot org', '@altlinux.org')
        maintainer_email.gsub!(' at altlinux dot ru', '@altlinux.org')
        maintainer_email.gsub!(' at altlinux dot net', '@altlinux.org')
        maintainer_email.gsub!(' at altlinux dot com', '@altlinux.org')
        maintainer_email.gsub!('@altlinux.ru', '@altlinux.org')
        maintainer_email.gsub!('@altlinux.net', '@altlinux.org')
        maintainer_email.gsub!('@altlinux.com', '@altlinux.org')
        maintainer_email.gsub!(' at packages.altlinux.org', '@packages.altlinux.org')
        maintainer_email.gsub!(' at packages.altlinux.ru', '@packages.altlinux.org')
        maintainer_email.gsub!(' at packages.altlinux.net', '@packages.altlinux.org')
        maintainer_email.gsub!(' at packages.altlinux.com', '@packages.altlinux.org')
        maintainer_email.gsub!('@packages.altlinux.ru', '@packages.altlinux.org')
        maintainer_email.gsub!('@packages.altlinux.net', '@packages.altlinux.org')
        maintainer_email.gsub!('@packages.altlinux.com', '@packages.altlinux.org')

        maintainer_login = maintainer_email.split('@')[0]
        maintainer_domain = maintainer_email.split('@')[1]

        if maintainer_domain == 'packages.altlinux.org'
          if Maintainer.count(:all, :conditions => { :team => true, :login => '@' + maintainer_login, :name => maintainer_name, :email => maintainer_email }) == 0
            Maintainer.create(:team => true, :login => '@' + maintainer_login, :name => maintainer_name, :email => maintainer_email)
          end
        else
          if Maintainer.count(:all, :conditions => { :team => false, :login => maintainer_login, :name => maintainer_name, :email => maintainer_email }) == 0
            Maintainer.create(:team => false, :login => maintainer_login, :name => maintainer_name, :email => maintainer_email)
          end
        end
      rescue RuntimeError
        puts "Bad src.rpm -- " + file
      end
    end
  end

  def self.find_all_maintainers_in_sisyphus
    find_by_sql("SELECT COUNT(acls.srpm_id) AS counter,
                        maintainers.name AS name,
                        maintainers.login AS login
                 FROM acls, maintainers, branches
                 WHERE maintainers.id = acls.maintainer_id
                 AND maintainers.team = 'false'
                 AND acls.branch_id = branches.id
                 AND branches.name = 'Sisyphus'
                 AND branches.vendor = 'ALT Linux'
                 GROUP BY maintainers.name, maintainers.login
                 ORDER BY maintainers.name ASC")
  end

  def self.find_all_teams_in_sisyphus
    find_by_sql("SELECT COUNT(acls.srpm_id) AS counter,
                        maintainers.name AS name,
                        maintainers.login AS login
                 FROM acls, maintainers, branches
                 WHERE maintainers.id = acls.maintainer_id
                 AND maintainers.team = 'true'
                 AND acls.branch_id = branches.id
                 AND branches.name = 'Sisyphus'
                 AND branches.vendor = 'ALT Linux'
                 GROUP BY maintainers.name, maintainers.login
                 ORDER BY maintainers.name ASC")
  end

  def self.top15
    find_by_sql("SELECT COUNT(acls.srpm_id) AS counter,
                        maintainers.name AS name,
                        maintainers.login AS login
                 FROM branches, acls, maintainers
                 WHERE branches.name = 'Sisyphus'
                 AND branches.vendor = 'ALT Linux'
                 AND branches.id = acls.branch_id
                 AND acls.maintainer_id = maintainers.id
                 AND maintainers.team = 'false'
                 GROUP BY maintainers.name, maintainers.login
                 ORDER BY 1 DESC LIMIT 15")
  end
end
