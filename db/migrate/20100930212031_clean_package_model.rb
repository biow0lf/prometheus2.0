# encoding: utf-8

class CleanPackageModel < ActiveRecord::Migration
  def up
    remove_column :packages, :branch
    remove_column :packages, :vendor
  end

  def down
    add_column :packages, :branch, :string
    add_column :packages, :vendor, :string
  end
end
