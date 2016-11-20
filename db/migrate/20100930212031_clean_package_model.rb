class CleanPackageModel < ActiveRecord::Migration[4.2]
  def change
    remove_column :packages, :branch
    remove_column :packages, :vendor
  end
end
