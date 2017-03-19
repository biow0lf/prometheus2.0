class CleanPackageModel < ActiveRecord::Migration[4.2]
  def change
    remove_column :packages, :branch, :string
    remove_column :packages, :vendor, :string
  end
end
