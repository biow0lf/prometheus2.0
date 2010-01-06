class AddVendorToLeaders < ActiveRecord::Migration
  def self.up
    add_column :leaders, :vendor, :string
  end

  def self.down
    remove_column :leaders, :vendor
  end
end
