# encoding: utf-8

class AddNestedSetFieldsToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :parent_id, :integer
    add_column :groups, :lft, :integer
    add_column :groups, :rgt, :integer
  end
end
