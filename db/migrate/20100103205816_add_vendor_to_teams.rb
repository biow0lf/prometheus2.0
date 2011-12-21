# encoding: utf-8

class AddVendorToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :vendor, :string
  end
end
