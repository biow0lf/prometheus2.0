class RemoveUrlFromBranches < ActiveRecord::Migration[4.2]
  def change
    remove_column :branches, :url, :string
  end
end
