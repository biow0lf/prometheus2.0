# encoding: utf-8

class CreateTeams < ActiveRecord::Migration
  def up
    create_table :teams do |t|
      t.string :name
      t.string :login
      t.string :branch
      t.boolean :leader

      t.timestamps
    end
  end

  def down
    drop_table :teams
  end
end
