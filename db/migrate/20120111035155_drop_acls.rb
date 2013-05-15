class DropAcls < ActiveRecord::Migration
  def change
    drop_table :acls
  end
end
