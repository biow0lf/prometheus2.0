# encoding: utf-8

class AddBranchIdToRepocop < ActiveRecord::Migration
  def change
    add_column :repocops, :branch_id, :integer
  end
end
