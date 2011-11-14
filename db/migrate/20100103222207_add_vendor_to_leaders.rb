# encoding: utf-8

class AddVendorToLeaders < ActiveRecord::Migration
  def up
    add_column :leaders, :vendor, :string
  end

  def down
    remove_column :leaders, :vendor
  end
end
