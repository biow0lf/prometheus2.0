class AddBranchIdToLeaders < ActiveRecord::Migration
  def up
    add_column :leaders, :branch_id, :integer
  end

  def down
    remove_column :leaders, :branch_id
  end
end