class AddVendorToLeaders < ActiveRecord::Migration
  def change
    add_column :leaders, :vendor, :string
  end
end
