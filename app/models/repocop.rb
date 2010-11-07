class Repocop < ActiveRecord::Base
  validates :name, :presence => true
  validates :version, :presence => true
  validates :release, :presence => true
  validates :arch, :presence => true
  validates :srcname, :presence => true
  validates :srcversion, :presence => true
  validates :srcrel, :presence => true
  validates :testname, :presence => true

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
  
  def self.update_repocop_cache
    branch = Branch.where(:vendor => 'ALT Linux', :name => 'Sisyphus').first
    srpms = branch.srpms.all
    srpms.each do |srpm|
      repocops = Repocop.where(:srcname => srpm.name,
                               :srcversion => srpm.version,
                               :srcrel => srpm.release).all

      repocop_status = 'skip'
      repocops.each do |repocop|
        repocop_status = 'ok' if repocop.status == 'ok' and repocop_status != 'info' and repocop_status != 'experimental' and repocop_status != 'warn' and repocop_status != 'fail'
        repocop_status = 'info' if repocop.status == 'info' and repocop_status != 'experimental' and repocop_status != 'warn' and repocop_status != 'fail'
        repocop_status = 'experimental' if repocop.status == 'experimental' and repocop_status != 'warn' and repocop_status != 'fail'
        repocop_status = 'warn' if repocop.status == 'warn' and repocop_status != 'fail'
        repocop_status = 'fail' if repocop.status == 'fail'
      end
      srpm.repocop = repocop_status
      srpm.save!
    end
  end
end