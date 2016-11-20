class RemoveUrlFromBranches < ActiveRecord::Migration[4.2]
  def change
    remove_column :branches, :url
  end
end
