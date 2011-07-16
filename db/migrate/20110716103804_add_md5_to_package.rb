class AddMd5ToPackage < ActiveRecord::Migration
  def self.up
    add_column :packages, :md5, :string
  end

  def self.down
    remove_column :packages, :md5
  end
end
