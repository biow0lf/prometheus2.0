# encoding: utf-8

class CreateLeaders < ActiveRecord::Migration
  def change
    create_table :leaders do |t|
      t.string :package
      t.string :login
      t.string :branch

      t.timestamps
    end
  end
end
