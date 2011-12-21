# encoding: utf-8

class UpdateProvideModel < ActiveRecord::Migration
  def change
    remove_column :provides, :type
    add_column :provides, :epoch, :string
    add_column :provides, :flags, :integer
  end
end
