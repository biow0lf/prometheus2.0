# encoding: utf-8

class RemoveRpmGroupsUrlFromBranches < ActiveRecord::Migration
  def change
    remove_column :branches, :rpm_groups_url
  end
end
