class RemoveRpmGroupsUrlFromBranches < ActiveRecord::Migration
  def self.up
    remove_column :branches, :rpm_groups_url
  end

  def self.down
    add_column :branches, :rpm_groups_url, :string
  end
end