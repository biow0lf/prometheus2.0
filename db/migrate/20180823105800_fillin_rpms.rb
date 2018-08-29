class FillinRpms < ActiveRecord::Migration[5.2]
   def change
      rename_table :named_srpms, :rpms

      reversible do |dir|
         dir.down do
           add_foreign_key :rpms, to_table: :srpms, on_delete: :cascade
         end
      end

      add_reference :rpms, :package, foreign_key: { on_delete: :cascade }, comment: "Ссылка на пакет"
      change_column_null :rpms, :branch_path_id, true
      change_column_null :rpms, :srpm_id, true

      reversible do |dir|
         dir.up do
            [
                 "UPDATE rpms
                     SET package_id = packages.id
                    FROM packages
                   WHERE packages._src_id IS NOT NULL
                     AND rpms.srpm_id = packages._src_id",
                 "INSERT INTO rpms
                             (filename, name, package_id, created_at, updated_at)
                       SELECT filename, name, id, created_at, updated_at
                         FROM packages
                        WHERE packages.type = 'Package::Built'",
            ].each { |q| Branch.connection.execute(q) }

            remove_foreign_key :rpms, to_table: :srpms, on_delete: :cascade
         end

         dir.down do
            add_foreign_key :rpms, :srpms, on_delete: :cascade

            Package.connection.execute <<-SQL
                  DELETE FROM rpms
                        USING packages
                        WHERE packages.id = rpms.package_id
                          AND packages.type = 'Package::Built'
            SQL
         end
      end

      change_column_null :rpms, :package_id, false
      remove_reference :rpms, :srpm, null: false, comment: "Отношение к содержимому srpm"
      add_index :rpms, %i(branch_path_id package_id), unique: true
   end
end
