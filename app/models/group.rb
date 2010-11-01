class Group < ActiveRecord::Base
  acts_as_nested_set

  validates_presence_of :name
  belongs_to :branch
  has_many :srpms
  has_many :packages

  def self.find_groups_in_sisyphus
    find_by_sql("SELECT COUNT(srpms.name) AS counter, groups.name
                 FROM srpms, groups, branches
                 WHERE groups.branch_id = branches.id
                 AND branches.name = 'Sisyphus'
                 AND branches.vendor = 'ALT Linux'
                 AND srpms.group_id = groups.id
                 AND srpms.branch_id = branches.id
                 GROUP BY groups.name
                 ORDER BY groups.name")
  end

  def self.import_groups(vendor, branch, url)
    br = Branch.first :conditions => { :name => branch, :vendor => vendor }
    if br.groups.count(:all) == 0
      file = open(URI.escape(url)).read
      file.each_line do |line|
        line.gsub!(/\n/,'')
        
        param0 = line.split('/')[0]
        param1 = line.split('/')[1]
        param2 = line.split('/')[2]
        
        if !Group.first(:conditions => { :name => param0, :branch_id => br.id, :parent_id => nil } )
          group0 = Group.create(:name => param0, :branch_id => br.id)
        else
          group0 = Group.first(:conditions => { :name => param0, :branch_id => br.id, :parent_id => nil } )
        end
        
        if param1 != nil
          if !Group.first(:conditions => { :name => param1, :branch_id => br.id, :parent_id => group0.id } )
            group1 = Group.create(:name => param1, :branch_id => br.id)
            group1.move_to_child_of(group0)
          else
            group1 = Group.first(:conditions => { :name => param1, :branch_id => br.id, :parent_id => group0.id } )
          end
        end
        
        if param2 != nil
          group2 = Group.create(:name => param2, :branch_id => br.id)
          group2.move_to_child_of(group1)
        end
      end
    else
      puts Time.now.to_s + ": groups already imported"
    end
  end
end