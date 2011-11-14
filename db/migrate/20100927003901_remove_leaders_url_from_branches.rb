# encoding: utf-8

class RemoveLeadersUrlFromBranches < ActiveRecord::Migration
  def up
    remove_column :branches, :leaders_url
  end

  def down
    add_columnt :branches, :leaders_url, :string
  end
end
