# encoding: utf-8

class CreateLeaders < ActiveRecord::Migration
  def up
    create_table :leaders do |t|
      t.string :package
      t.string :login
      t.string :branch

      t.timestamps
    end
  end

  def down
    drop_table :leaders
  end
end
