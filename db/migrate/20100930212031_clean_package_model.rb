class CleanPackageModel < ActiveRecord::Migration
  def change
    remove_column :packages, :branch
    remove_column :packages, :vendor
  end
end
