class Leader < ActiveRecord::Base
  validates_presence_of :package, :login, :branch, :vendor

  def self.update_from_gitalt(vendor, branch)
    ActiveRecord::Base.transaction do
      url = Branch.find :first, :conditions => { :vendor => 'ALT Linux' , :name => 'Sisyphus' }
      ActiveRecord::Base.connection.execute("DELETE FROM leaders WHERE branch = '" + branch + "' AND vendor = '" + vendor "'")

      file = open(URI.escape(url.acls_url)).read

      file.each_line do |line|
        package = line.split[0]
        login = line.split[1]
        Leader.create :package => package, :login => login, :branch => branch, :vendor => vendor
      end
    end
  end

end
