class RemoveRpmGroupsUrlFromBranches < ActiveRecord::Migration[4.2]
  def change
    remove_column :branches, :rpm_groups_url
  end
end
