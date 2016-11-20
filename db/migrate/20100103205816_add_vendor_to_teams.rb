class AddVendorToTeams < ActiveRecord::Migration[4.2]
  def change
    add_column :teams, :vendor, :string
  end
end
