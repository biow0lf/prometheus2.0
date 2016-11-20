class AddBranchIdToRepocop < ActiveRecord::Migration[4.2]
  def change
    add_column :repocops, :branch_id, :integer
  end
end
