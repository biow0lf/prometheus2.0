class AddBranchIdToGroups < ActiveRecord::Migration[4.2]
  def change
    add_column :groups, :branch_id, :integer
  end
end
