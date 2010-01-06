class Group < ActiveRecord::Base
  validates_presence_of :name, :branch, :vendor

  def self.find_groups_in_sisyphus
    find_by_sql("SELECT COUNT(srpms.name) AS counter, groups.name
                 FROM srpms, groups, branches
                 WHERE groups.branch = branches.name
                 AND branches.name = 'Sisyphus'
                 AND srpms.group = groups.name
                 AND srpms.branch = branches.name
                 GROUP BY groups.name
                 ORDER BY groups.name")
  end

  def self.update_from_gitalt(vendor, branch)
    url = Branch.first :conditions => { :vendor => vendor, :name => branch }

    ActiveRecord::Base.transaction do
      ActiveRecord::Base.connection.execute("DELETE FROM groups WHERE branch = '" + branch.to_s + "' AND vendor = '" + vendor.to_s + "'")
      file = open(URI.escape(url.rpm_groups_url)).read
      file.each_line do |line|
        Group.create :name => line.gsub(/\n/,''), :branch => branch, :vendor => vendor
      end
    end
  end
end
