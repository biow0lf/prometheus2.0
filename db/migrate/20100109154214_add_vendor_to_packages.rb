class AddVendorToPackages < ActiveRecord::Migration
  def self.up
    add_column :packages, :vendor, :string
  end

  def self.down
    remove_column :packages, :vendor
  end
end
