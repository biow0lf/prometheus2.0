class Group < ActiveRecord::Base
  acts_as_nested_set

  belongs_to :branch

  validates :branch, :presence => true
  validates :name, :presence => true

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

  def self.import_groups(vendor_name, branch_name, url)
    branch = Branch.where(:name => branch_name, :vendor => vendor_name).first
    if branch.groups.count(:all) == 0
      file = open(URI.escape(url)).read
      file.each_line do |line|
        line.gsub!(/\n/,'')

        param0 = line.split('/')[0]
        param1 = line.split('/')[1]
        param2 = line.split('/')[2]

        if !Group.first(:conditions => { :name => param0, :branch => branch, :parent_id => nil })
          group0 = Group.create(:name => param0, :branch => branch)
        else
          group0 = Group.first(:conditions => { :name => param0, :branch => branch, :parent_id => nil })
        end

        if param1 != nil
          if !Group.first(:conditions => { :name => param1, :branch => branch, :parent_id => group0.id })
            group1 = Group.create(:name => param1, :branch => branch)
            group1.move_to_child_of(group0)
          else
            group1 = Group.first(:conditions => { :name => param1, :branch => branch, :parent_id => group0.id })
          end
        end

        if param2 != nil
          group2 = Group.create(:name => param2, :branch => branch)
          group2.move_to_child_of(group1)
        end
      end
    else
      puts "#{Time.now.to_s}: groups already imported"
    end
  end
end
