class AddOrderIdToBranches < ActiveRecord::Migration[4.2]
  def change
    add_column :branches, :order_id, :integer
  end
end
