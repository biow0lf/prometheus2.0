class AddBranchIdToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :branch_id, :integer
  end
end
