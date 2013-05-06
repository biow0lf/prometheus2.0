class AddVendorToSrpm < ActiveRecord::Migration
  def change
    add_column :srpms, :vendor, :string
  end
end
