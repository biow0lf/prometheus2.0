# encoding: utf-8

class RemoveLoginFromLeaderModel < ActiveRecord::Migration
  def up
    remove_column :leaders, :login
  end

  def down
    add_column :leaders, :login, :string
  end
end
