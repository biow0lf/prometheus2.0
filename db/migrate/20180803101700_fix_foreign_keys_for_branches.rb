class FixForeignKeysForBranches < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key "ftbfs", "branches", on_delete: :cascade
    add_foreign_key "groups", "branches", on_delete: :cascade
    add_foreign_key "mirrors", "branches", on_delete: :cascade
    add_foreign_key "repocop_patches", "branches", on_delete: :cascade
    add_foreign_key "repocops", "branches", on_delete: :cascade
    add_foreign_key "teams", "branches", on_delete: :cascade
  end
end
