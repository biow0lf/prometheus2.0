# encoding: utf-8

class RemoveLoginFromLeaderModel < ActiveRecord::Migration
  def change
    remove_column :leaders, :login
  end
end
