# encoding: utf-8

class CleanLeadersModel < ActiveRecord::Migration
  def up
    remove_column :leaders, :branch
    remove_column :leaders, :vendor
  end

  def down
    add_column :leaders, :branch, :string
    add_column :leaders, :vendor, :string
  end
end
