# encoding: utf-8

class CreateMirrors < ActiveRecord::Migration
  def change
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
end
