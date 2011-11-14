# encoding: utf-8

class CreatePackagers < ActiveRecord::Migration
  def up
    create_table :packagers do |t|
      t.string :name
      t.string :email
      t.string :login
      t.boolean :team

      t.timestamps
    end
  end

  def down
    drop_table :packagers
  end
end
