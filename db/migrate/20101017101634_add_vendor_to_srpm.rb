class AddVendorToSrpm < ActiveRecord::Migration
  def self.up
    add_column :srpms, :vendor, :string
  end

  def self.down
    remove_column :srpms, :vendor
  end
end