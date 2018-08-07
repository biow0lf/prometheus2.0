class AddBranchPathToNamedSrpms < ActiveRecord::Migration[5.1]
   def change
      change_table :named_srpms do |t|
         t.references :branch_path, comment: "Указатель на путь к ветви, откуда пакет был истянут"

         t.index %i(branch_path_id srpm_id), unique: true
         t.index %i(branch_path_id name), unique: true
      end

      add_foreign_key :named_srpms, :branch_paths, on_delete: :cascade

      reversible do |dir|
         dir.up do
            ActiveRecord::Base.connection.execute("UPDATE named_srpms SET branch_path_id = branch_paths.id FROM branch_paths WHERE named_srpms.branch_id = branch_paths.branch_id")
         end
      end

      change_column_null :named_srpms, :branch_path_id, false

      remove_foreign_key :named_srpms, :branches
      remove_index :named_srpms, column: %i(branch_id srpm_id), unique: true
      remove_index :named_srpms, column: %i(branch_id name), unique: true
      remove_column :named_srpms, :branch_id, :bigint
   end
end
