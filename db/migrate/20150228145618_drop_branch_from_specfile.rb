class DropBranchFromSpecfile < ActiveRecord::Migration
  def change
    remove_index :specfiles, :branch_id
    remove_column :specfiles, :branch_id
  end
end
