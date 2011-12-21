# encoding: utf-8

class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.string :login
      t.string :branch
      t.boolean :leader

      t.timestamps
    end
  end
end
