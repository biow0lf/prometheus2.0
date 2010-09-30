class CleanPackageModel < ActiveRecord::Migration
  def self.up
    remove_column :packages, :branch
    remove_column :packages, :vendor
  end

  def self.down
    add_column :packages, :branch, :string
    add_column :packages, :vendor, :string
  end
end