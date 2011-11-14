# encoding: utf-8

class RemoveGroupFromSrpmModel < ActiveRecord::Migration
  def up
    remove_column :srpms, :group
  end

  def down
    add_column :srpms, :group, :string
  end
end
