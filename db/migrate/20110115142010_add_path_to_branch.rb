class AddPathToBranch < ActiveRecord::Migration
  def change
    add_column :branches, :path, :string
  end
end
