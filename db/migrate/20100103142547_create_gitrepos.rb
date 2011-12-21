# encoding: utf-8

class CreateGitrepos < ActiveRecord::Migration
  def change
    create_table :gitrepos do |t|
      t.string :repo
      t.string :login
      t.datetime :lastchange

      t.timestamps
    end
  end
end
