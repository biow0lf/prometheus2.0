class AddVendorToPackages < ActiveRecord::Migration[4.2]
  def change
    add_column :packages, :vendor, :string
  end
end
