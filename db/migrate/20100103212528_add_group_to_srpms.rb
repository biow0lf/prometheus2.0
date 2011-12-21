# encoding: utf-8

class AddGroupToSrpms < ActiveRecord::Migration
  def change
    add_column :srpms, :group, :string
  end
end
