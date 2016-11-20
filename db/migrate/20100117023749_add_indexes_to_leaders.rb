class AddIndexesToLeaders < ActiveRecord::Migration[4.2]
  def change
    add_index :leaders, :branch
    add_index :leaders, :vendor
    add_index :leaders, :package
  end
end
