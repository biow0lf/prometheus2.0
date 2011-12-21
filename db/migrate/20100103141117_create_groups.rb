# encoding: utf-8

class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :branch
      t.string :vendor

      t.timestamps
    end
  end
end
