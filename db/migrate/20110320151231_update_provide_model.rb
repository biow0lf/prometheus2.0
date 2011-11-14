# encoding: utf-8

class UpdateProvideModel < ActiveRecord::Migration
  def up
    remove_column :provides, :type
    add_column :provides, :epoch, :string
    add_column :provides, :flags, :integer
  end

  def down
    add_column :provides, :type, :string
    remove_column :provides, :epoch
    remove_column :provides, :flags
  end
end
