# encoding: utf-8

class AddFlagsToRequires < ActiveRecord::Migration
  def up
    add_column :requires, :flags, :integer
  end

  def down
    remove_column :requires, :flags
  end
end
