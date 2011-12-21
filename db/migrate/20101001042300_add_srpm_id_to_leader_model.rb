# encoding: utf-8

class AddSrpmIdToLeaderModel < ActiveRecord::Migration
  def change
    add_column :leaders, :srpm_id, :integer
    add_index :leaders, :srpm_id
    remove_column :leaders, :package
    add_column :leaders, :packager_id, :integer
    add_index :leaders, :packager_id
  end
end
