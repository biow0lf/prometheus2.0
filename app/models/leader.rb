class Leader < ActiveRecord::Base
  #validates_presence_of :package, :login
  belongs_to :branch
  belongs_to :packager
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
          packager = Packager.first :conditions => { :login => login }
          if packager.nil?
            puts "BAD: " + login
          elsif srpm.nil?
            puts "BAD: " + package
          else 
            #Leader.create :package => package, :login => login, :branch_id => br.id
            # FIXME: if leader not packager, it will broke
            Leader.create :srpm_id => srpm.id, :branch_id => br.id, :packager_id => packager.id
          end
        end      
      end
    else
      puts Time.now.to_s + ": leaders already imported"
    end
  end

#  def self.update_leaders(vendor, branch, url)
#    ActiveRecord::Base.transaction do
#      ActiveRecord::Base.connection.execute("DELETE FROM leaders WHERE branch = '" + branch + "' AND vendor = '" + vendor + "'")
#
#      file = open(URI.escape(url)).read
#
#      file.each_line do |line|
#        package = line.split[0]
#        login = line.split[1]
#        Leader.create :package => package, :login => login, :branch => branch, :vendor => vendor
#      end
#    end
#  end
end