class CreateMirrors < ActiveRecord::Migration
  def self.up
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

  def self.down
    drop_table :mirrors
  end
end
