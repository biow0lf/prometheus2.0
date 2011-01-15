class AddPathToBranch < ActiveRecord::Migration
  def self.up
    add_column :branches, :path, :string
  end

  def self.down
    remove_column :branches, :path
  end
end
