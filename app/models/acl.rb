class Acl < ActiveRecord::Base
  validates_presence_of :package, :login
  belongs_to :branch

# FIXME:
#  has_one :srpm, :foreign_key => 'name', :primary_key => 'package', :conditions => { :branch => '#{self.branch}', :vendor => '#{self.vendor}' }

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
            #login = '@vim-plugins' if login == '@vim_plugins'
            #login = 'p_solntsev' if login == 'psolntsev'
            Acl.create :package => package, :login => login, :branch_id => br.id
          end
        end
      end
    else
      puts Time.now.to_s + ": acls already imported"
    end
  end


# FIXME:
#  def self.update_acls(vendor, branch, url)
#    ActiveRecord::Base.transaction do
#      ActiveRecord::Base.connection.execute("DELETE FROM acls WHERE branch = '" + branch + "' AND vendor = '" + vendor + "'")
#
#      file = open(URI.escape(url)).read
#      file.each_line do |line|
#        package = line.split[0]
#        for i in 1..line.split.count-1
#          login = line.split[i]
#          login = 'php-coder' if login == 'php_coder'
#          login = '@vim-plugins' if login == '@vim_plugins'
#          login = 'p_solntsev' if login == 'psolntsev'
#
#          Acl.create :package => package, :login => login, :branch => branch, :vendor => vendor
#        end
#      end
#    end
#  end
end