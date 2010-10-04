class Maintainer < ActiveRecord::Base
  validates_presence_of :name, :email, :login
  validates_uniqueness_of :login
  
  has_one :leader
#
#  has_many :acls, :foreign_key => 'login', :primary_key => 'login'
#
#  has_many :sisyphus, :class_name => 'Acl', :foreign_key => 'login', :primary_key => 'login', :conditions => { :branch => 'Sisyphus', :vendor => 'ALT Linux' }, :order => 'LOWER(package)'
#
#  has_one :srpm, :through => :acls, :order => "name ASC"

  def self.import_packagers_list(path)
    Dir.glob(path).each do |file|
      begin
        rpm = RPM::Package::open(file)
        packager = rpm[1015]
        packager_name = packager.split('<')[0].chomp
        packager_name.strip!
        packager_email = packager.chop.split('<')[1]

        packager_email.downcase!

        packager_email.gsub!(' at altlinux.ru', '@altlinux.org')
        packager_email.gsub!(' at altlinux.org', '@altlinux.org')
        packager_email.gsub!(' at altlinux.net', '@altlinux.org')
        packager_email.gsub!(' at altlinux.com', '@altlinux.org')
        packager_email.gsub!(' at altlinux dot org', '@altlinux.org')
        packager_email.gsub!(' at altlinux dot ru', '@altlinux.org')
        packager_email.gsub!(' at altlinux dot net', '@altlinux.org')
        packager_email.gsub!(' at altlinux dot com', '@altlinux.org')
        packager_email.gsub!('@altlinux.ru', '@altlinux.org')
        packager_email.gsub!('@altlinux.net', '@altlinux.org')
        packager_email.gsub!('@altlinux.com', '@altlinux.org')
        packager_email.gsub!(' at packages.altlinux.org', '@packages.altlinux.org')
        packager_email.gsub!(' at packages.altlinux.ru', '@packages.altlinux.org')
        packager_email.gsub!(' at packages.altlinux.net', '@packages.altlinux.org')
        packager_email.gsub!(' at packages.altlinux.com', '@packages.altlinux.org')
        packager_email.gsub!('@packages.altlinux.ru', '@packages.altlinux.org')
        packager_email.gsub!('@packages.altlinux.net', '@packages.altlinux.org')
        packager_email.gsub!('@packages.altlinux.com', '@packages.altlinux.org')

        packager_login = packager_email.split('@')[0]
        packager_domain = packager_email.split('@')[1]

        packager2 = Maintainer.new

        if packager_domain == 'packages.altlinux.org'
          if Maintainer.count(:all, :conditions => { :team => true, :login => '@' + packager_login, :name => packager_name, :email => packager_email }) == 0
            Maintainer.create :team => true, :login => '@' + packager_login, :name => packager_name, :email => packager_email
          end
        else
          if Maintainer.count(:all, :conditions => { :team => false, :login => packager_login, :name => packager_name, :email => packager_email }) == 0
            Maintainer.create :team => false, :login => packager_login, :name => packager_name, :email => packager_email
          end
        end
      rescue RuntimeError
        puts "Bad src.rpm -- " + file
      end
    end
  end

  def self.find_all_packagers_in_sisyphus
    find_by_sql("SELECT COUNT(acls.package) AS counter,
                        maintainers.name AS name,
                        maintainers.login AS login
                 FROM acls, maintainers, branches
                 WHERE maintainers.login = acls.login
                 AND maintainers.team = false
                 AND acls.branch_id = branches.id
                 AND branches.name = 'Sisyphus'
                 AND branches.vendor = 'ALT Linux'
                 GROUP BY maintainers.name, maintainers.login
                 ORDER BY maintainers.name ASC")
  end

  def self.find_all_teams_in_sisyphus
    find_by_sql("SELECT COUNT(acls.package) AS counter,
                        maintainers.name AS name,
                        maintainers.login AS login
                 FROM acls, maintainers, branches
                 WHERE maintainers.login = acls.login
                 AND maintainers.team = true
                 AND acls.branch_id = branches.id
                 AND branches.name = 'Sisyphus'
                 AND branches.vendor = 'ALT Linux'
                 GROUP BY maintainers.name, maintainers.login
                 ORDER BY maintainers.name ASC")
  end

  def self.top15
    find_by_sql("SELECT COUNT(acls.package) AS counter,
                        maintainers.name AS name,
                        maintainers.login AS login
                 FROM branches, acls, maintainers
                 WHERE branches.name = 'Sisyphus'
                 AND branches.vendor = 'ALT Linux'
                 AND branches.id = acls.branch_id
                 AND acls.login = maintainers.login
                 AND maintainers.team = false
                 GROUP BY maintainers.name, maintainers.login
                 ORDER BY 1 DESC LIMIT 15")
  end
end