class CreateMirrors < ActiveRecord::Migration
  def up
    create_table :mirrors do |t|
      t.integer :branch_id
      t.integer :order_id
      t.string :name
      t.string :country
      t.string :uri
      t.string :protocol

      t.timestamps
    end
  end

  def down
    drop_table :mirrors
  end
end
