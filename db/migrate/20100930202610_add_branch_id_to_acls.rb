class AddBranchIdToAcls < ActiveRecord::Migration
  def change
    add_column :acls, :branch_id, :integer
  end
end
