class RemoveSizeFromPackage < ActiveRecord::Migration
  def change
    remove_column :packages, :size
  end
end
