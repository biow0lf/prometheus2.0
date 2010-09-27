class RemoveLeadersUrlFromBranches < ActiveRecord::Migration
  def self.up
    remove_column :branches, :leaders_url
  end

  def self.down
    add_columnt :branches, :leaders_url, :string
  end
end