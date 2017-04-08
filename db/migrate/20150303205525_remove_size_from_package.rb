class RemoveSizeFromPackage < ActiveRecord::Migration[4.2]
  def change
    remove_column :packages, :size, :string
  end
end
