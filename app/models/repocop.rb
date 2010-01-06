class Repocop < ActiveRecord::Base
  validates_presence_of :name, :version, :release, :arch, :srcname, :srcversion, :srcrel, :testname

  def self.update_repocop
    ActiveRecord::Base.transaction do
      Repocop.delete_all

      url = "http://repocop.altlinux.org/pub/repocop/prometeus2/prometeus2.txt"
      file = open(URI.escape(url)).read

      file.each_line do |line|
        ActiveRecord::Base.connection.execute(line)
      end
    end
  end
end
