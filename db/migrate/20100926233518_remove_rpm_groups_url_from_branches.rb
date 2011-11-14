# encoding: utf-8

class RemoveRpmGroupsUrlFromBranches < ActiveRecord::Migration
  def up
    remove_column :branches, :rpm_groups_url
  end

  def down
    add_column :branches, :rpm_groups_url, :string
  end
end
