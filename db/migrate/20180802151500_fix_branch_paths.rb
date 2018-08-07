class FixBranchPaths < ActiveRecord::Migration[5.1]
  def change
    change_table :branch_paths do |t|
      t.bigint :source_path_id, comment: "Указатель на путь к ветви родительских пакетов"

      t.index %i(source_path_id)
    end

    add_foreign_key "branch_paths", "branch_paths", column: :source_path_id, on_delete: :cascade
    remove_foreign_key "branch_paths", "branches"
    add_foreign_key "branch_paths", "branches", on_delete: :cascade
  end
end
