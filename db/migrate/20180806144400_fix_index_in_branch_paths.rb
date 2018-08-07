class FixIndexInBranchPaths < ActiveRecord::Migration[5.1]
  def change
    change_table :branch_paths do |t|
      t.remove_index column: %i(branch_id arch), unique: true

      t.index %i(arch branch_id source_path_id), unique: true
    end
  end
end
