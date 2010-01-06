class AddVendorToTeams < ActiveRecord::Migration
  def self.up
    add_column :teams, :vendor, :string
  end

  def self.down
    remove_column :teams, :vendor
  end
end
