# encoding: utf-8

class AddIndexesToRepocops < ActiveRecord::Migration
  def up
    add_index :repocops, :srcname
    add_index :repocops, :srcversion
    add_index :repocops, :srcrel
  end

  def down
    remove_index :repocops, :srcname
    remove_index :repocops, :srcversion
    remove_index :repocops, :srcrel
  end
end
