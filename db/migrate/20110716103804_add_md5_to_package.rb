class AddMd5ToPackage < ActiveRecord::Migration[4.2]
  def change
    add_column :packages, :md5, :string
  end
end
