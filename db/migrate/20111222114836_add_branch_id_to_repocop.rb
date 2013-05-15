class AddBranchIdToRepocop < ActiveRecord::Migration
  def change
    add_column :repocops, :branch_id, :integer
  end
end
