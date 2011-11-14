# encoding: utf-8

class AddOrderIdToBranches < ActiveRecord::Migration
  def up
    add_column :branches, :order_id, :integer
  end

  def down
    remove_column :branches, :order_id
  end
end
