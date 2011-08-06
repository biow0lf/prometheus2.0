class AddBranchIdToAcls < ActiveRecord::Migration
  def up
    add_column :acls, :branch_id, :integer
  end

  def down
    remove_column :acls, :branch_id
  end
end