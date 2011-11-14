# encoding: utf-8

class AddVendorToTeams < ActiveRecord::Migration
  def up
    add_column :teams, :vendor, :string
  end

  def down
    remove_column :teams, :vendor
  end
end
