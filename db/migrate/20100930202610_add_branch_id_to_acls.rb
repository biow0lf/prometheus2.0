class AddBranchIdToAcls < ActiveRecord::Migration[4.2]
  def change
    add_column :acls, :branch_id, :integer
  end
end
