# encoding: utf-8

class AddIndexInGroupIdToSrpmModel < ActiveRecord::Migration
  def change
    add_index :srpms, :group_id
  end
end
