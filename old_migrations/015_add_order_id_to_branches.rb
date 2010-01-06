class AddOrderIdToBranches < ActiveRecord::Migration
  def self.up
    add_column :branches, :order_id, :integer
  end

  def self.down
    remove_column :branches, :order_id
  end
end
