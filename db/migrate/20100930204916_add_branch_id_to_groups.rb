class AddBranchIdToGroups < ActiveRecord::Migration
  def up
    add_column :groups, :branch_id, :integer
  end

  def down
    remove_column :groups, :branch_id
  end
end