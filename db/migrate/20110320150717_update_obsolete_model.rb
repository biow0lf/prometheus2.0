# encoding: utf-8

class UpdateObsoleteModel < ActiveRecord::Migration
  def up
    remove_column :obsoletes, :type
    add_column :obsoletes, :epoch, :string
    add_column :obsoletes, :flags, :integer
  end

  def down
    add_column :obsoletes, :type, :string
    remove_column :obsoletes, :epoch
    remove_column :obsoletes, :flags
  end
end
