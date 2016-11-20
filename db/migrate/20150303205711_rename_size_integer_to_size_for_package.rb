class RenameSizeIntegerToSizeForPackage < ActiveRecord::Migration[4.2]
  def change
    rename_column :packages, :size_integer, :size
  end
end
