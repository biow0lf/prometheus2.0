class AddNameToNamedSrpms < ActiveRecord::Migration[5.1]
   def change
      rename_column :named_srpms, :name, :filename

      change_table :named_srpms do |t|
         t.string :name, index: true, comment: "Имя исходного пакета"

         t.index :name
         t.remove_index :filename
         t.index :filename
      end

      reversible do |dir|
         dir.up do
            NamedSrpm.update_all("name = substring(filename from '^(.*)-[^-]+-[^-]+$')")
         end
      end

      change_column_null :named_srpms, :name, false

      remove_foreign_key "named_srpms", "srpms"
      add_foreign_key "named_srpms", "srpms", on_delete: :cascade
   end
end
