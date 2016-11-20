class AddGroupsUrlToBranches < ActiveRecord::Migration[4.2]
  def change
    add_column :branches, :rpm_groups_url, :string
  end
end
