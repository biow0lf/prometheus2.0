class AddMd5ToPackage < ActiveRecord::Migration
  def up
    add_column :packages, :md5, :string
  end

  def down
    remove_column :packages, :md5
  end
end
