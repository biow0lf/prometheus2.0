class AddPathToBranch < ActiveRecord::Migration[4.2]
  def change
    add_column :branches, :path, :string
  end
end
