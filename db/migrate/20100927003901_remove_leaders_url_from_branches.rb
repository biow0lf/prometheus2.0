# encoding: utf-8

class RemoveLeadersUrlFromBranches < ActiveRecord::Migration
  def change
    remove_column :branches, :leaders_url
  end
end
