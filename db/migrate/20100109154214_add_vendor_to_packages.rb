# encoding: utf-8

class AddVendorToPackages < ActiveRecord::Migration
  def up
    add_column :packages, :vendor, :string
  end

  def down
    remove_column :packages, :vendor
  end
end
