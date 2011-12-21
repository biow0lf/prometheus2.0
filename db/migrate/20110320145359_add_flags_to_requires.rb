# encoding: utf-8

class AddFlagsToRequires < ActiveRecord::Migration
  def change
    add_column :requires, :flags, :integer
  end
end
