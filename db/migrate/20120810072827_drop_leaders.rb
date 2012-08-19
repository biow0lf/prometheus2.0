# encoding: utf-8

class DropLeaders < ActiveRecord::Migration
  def change
    drop_table :leaders
  end
end
