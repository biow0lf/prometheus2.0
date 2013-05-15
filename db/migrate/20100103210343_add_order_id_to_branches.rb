class AddOrderIdToBranches < ActiveRecord::Migration
  def change
    add_column :branches, :order_id, :integer
  end
end
