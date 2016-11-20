class DropAcls < ActiveRecord::Migration[4.2]
  def change
    drop_table :acls
  end
end
