class AddVendorToLeaders < ActiveRecord::Migration[4.2]
  def change
    add_column :leaders, :vendor, :string
  end
end
