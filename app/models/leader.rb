class Leader < ActiveRecord::Base
  validates_presence_of :package, :login

  def self.update_leaders(vendor, branch, url)
    ActiveRecord::Base.transaction do
      ActiveRecord::Base.connection.execute("DELETE FROM leaders WHERE branch = '" + branch + "' AND vendor = '" + vendor + "'")

      file = open(URI.escape(url)).read

      file.each_line do |line|
        package = line.split[0]
        login = line.split[1]
        Leader.create :package => package, :login => login, :branch => branch, :vendor => vendor
      end
    end
  end
end