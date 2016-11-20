class AddBranchIdToLeaders < ActiveRecord::Migration[4.2]
  def change
    add_column :leaders, :branch_id, :integer
  end
end
