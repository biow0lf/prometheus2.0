class RenameSizeIntegerToSizeForPackage < ActiveRecord::Migration
  def change
    rename_column :packages, :size_integer, :size
  end
end
