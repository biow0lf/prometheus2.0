class AddVendorToSrpm < ActiveRecord::Migration[4.2]
  def change
    add_column :srpms, :vendor, :string
  end
end
