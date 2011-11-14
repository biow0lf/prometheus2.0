# encoding: utf-8

class CreateGitrepos < ActiveRecord::Migration
  def up
    create_table :gitrepos do |t|
      t.string :repo
      t.string :login
      t.datetime :lastchange

      t.timestamps
    end
  end

  def down
    drop_table :gitrepos
  end
end
