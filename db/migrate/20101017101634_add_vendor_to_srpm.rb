class AddVendorToSrpm < ActiveRecord::Migration
  def up
    add_column :srpms, :vendor, :string
  end

  def down
    remove_column :srpms, :vendor
  end
end