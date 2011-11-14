# encoding: utf-8

class AddGroupsUrlToBranches < ActiveRecord::Migration
  def up
    add_column :branches, :rpm_groups_url, :string
  end

  def down
    remove_column :branches, :rpm_groups_url
  end
end
