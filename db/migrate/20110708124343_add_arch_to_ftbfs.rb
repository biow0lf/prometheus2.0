# encoding: utf-8

class AddArchToFtbfs < ActiveRecord::Migration
  def change
    add_column :ftbfs, :arch, :string
  end
end
