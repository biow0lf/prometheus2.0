class AddBranchIdToTeams < ActiveRecord::Migration[4.2]
  def change
    add_column :teams, :branch_id, :integer
  end
end
