# encoding: utf-8

class AddGroupIdToSrpms < ActiveRecord::Migration
  def change
    add_column :srpms, :group_id, :integer
  end
end
