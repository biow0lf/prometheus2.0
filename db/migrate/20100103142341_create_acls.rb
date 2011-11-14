# encoding: utf-8

class CreateAcls < ActiveRecord::Migration
  def up
    create_table :acls do |t|
      t.string :package
      t.string :login
      t.string :branch
      t.string :vendor

      t.timestamps
    end
  end

  def down
    drop_table :acls
  end
end
