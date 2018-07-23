class AddUniqForMd5InSrpms < ActiveRecord::Migration[5.1]
  def change
    change_column_null :srpms, :md5, false
    add_index :srpms, :md5, unique: true
  end
end
