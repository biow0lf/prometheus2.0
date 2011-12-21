# encoding: utf-8

class AddGroupsUrlToBranches < ActiveRecord::Migration
  def change
    add_column :branches, :rpm_groups_url, :string
  end
end
