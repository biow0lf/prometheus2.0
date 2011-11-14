# encoding: utf-8

class CleanTeamModel < ActiveRecord::Migration
  def up
    remove_column :teams, :branch
    remove_column :teams, :vendor
  end

  def down
    add_column :teams, :branch, :string
    add_column :teams, :vendor, :string
  end
end
