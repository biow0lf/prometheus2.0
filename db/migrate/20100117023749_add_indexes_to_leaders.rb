# encoding: utf-8

class AddIndexesToLeaders < ActiveRecord::Migration
  def up
    add_index :leaders, :branch
    add_index :leaders, :vendor
    add_index :leaders, :package
  end

  def down
    remove_index :leaders, :branch
    remove_index :leaders, :vendor
    remove_index :leaders, :package
  end
end
