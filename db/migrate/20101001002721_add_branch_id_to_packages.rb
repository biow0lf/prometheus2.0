class AddBranchIdToPackages < ActiveRecord::Migration[4.2]
  def change
    add_column :packages, :branch_id, :integer
  end
end
