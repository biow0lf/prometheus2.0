class AddUniqForMd5InSrpms < ActiveRecord::Migration[5.1]
  def change
    ActiveRecord::Base.connection.execute("DELETE FROM packages WHERE NOT (srpm_id IN (SELECT id FROM srpms))")

    add_column :srpms, :alias, :string
    add_index :srpms, :alias

    change_column_null :srpms, :md5, false
    add_index :srpms, :md5, unique: true

    change_column_null :packages, :md5, false
    add_index :packages, :md5, unique: true

    add_foreign_key "packages", "srpms", on_delete: :cascade
  end
end
