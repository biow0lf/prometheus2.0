class Group < ActiveRecord::Base
  validates_presence_of :name
  belongs_to :branch

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

  def self.import_groups(vendor, branch, url)
    br = Branch.first :conditions => { :name => branch, :vendor => vendor }
    if br.groups.count(:all) == 0
      ActiveRecord::Base.transaction do
        file = open(URI.escape(url)).read
        file.each_line do |line|
          Group.create :name => line.gsub(/\n/,''), :branch_id => br.id
        end
      end
    else
      puts Time.now.to_s + ": groups already imported"
    end
  end
end