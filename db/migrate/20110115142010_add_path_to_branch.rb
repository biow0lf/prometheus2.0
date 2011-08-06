class AddPathToBranch < ActiveRecord::Migration
  def up
    add_column :branches, :path, :string
  end

  def down
    remove_column :branches, :path
  end
end
