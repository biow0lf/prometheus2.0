class AddGroupsUrlToBranches < ActiveRecord::Migration
  def self.up
    add_column :branches, :rpm_groups_url, :string
  end

  def self.down
    remove_column :branches, :rpm_groups_url
  end
end
