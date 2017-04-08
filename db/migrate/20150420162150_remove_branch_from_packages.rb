class RemoveBranchFromPackages < ActiveRecord::Migration[4.2]
  def change
    remove_index :packages, :branch_id
    remove_column :packages, :branch_id # , :integer
  end
end
