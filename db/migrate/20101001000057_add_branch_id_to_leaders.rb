class AddBranchIdToLeaders < ActiveRecord::Migration
  def change
    add_column :leaders, :branch_id, :integer
  end
end
