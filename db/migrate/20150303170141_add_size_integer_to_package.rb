class AddSizeIntegerToPackage < ActiveRecord::Migration
  def change
    add_column :packages, :size_integer, :integer
  end
end
