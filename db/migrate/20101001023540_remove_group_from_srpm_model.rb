# encoding: utf-8

class RemoveGroupFromSrpmModel < ActiveRecord::Migration
  def change
    remove_column :srpms, :group
  end
end
