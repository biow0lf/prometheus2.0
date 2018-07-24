class AddUniqForMd5InSrpms < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key "packages", "srpms", on_delete: :cascade

    add_column :srpms, :alias, :string
    add_index :srpms, :alias

    ActiveRecord::Base.connection.execute("DELETE FROM srpms a USING srpms b WHERE a.id > b.id AND a.md5 = b.md5")

    change_column_null :srpms, :md5, false
    add_index :srpms, :md5, unique: true

    ActiveRecord::Base.connection.execute("DELETE FROM packages a USING packages b WHERE a.id > b.id AND a.md5 = b.md5")

    change_column_null :packages, :md5, false
    add_index :packages, :md5, unique: true
  end
end
