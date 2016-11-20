class AddMd5ToSrpms < ActiveRecord::Migration[4.2]
  def change
    add_column :srpms, :md5, :string
  end
end
