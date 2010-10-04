class RemoveUrlFromBranches < ActiveRecord::Migration
  def self.up
    remove_column :branches, :url
  end

  def self.down
    add_column :branches, :url, :string
  end
end