# encoding: utf-8

class AddPathToBranch < ActiveRecord::Migration
  def change
    add_column :branches, :path, :string
  end
end
