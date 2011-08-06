class RemoveUrlFromBranches < ActiveRecord::Migration
  def up
    remove_column :branches, :url
  end

  def down
    add_column :branches, :url, :string
  end
end