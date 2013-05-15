class AddVendorToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :vendor, :string
  end
end
