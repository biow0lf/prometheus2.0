class RemoveLeadersUrlFromBranches < ActiveRecord::Migration[4.2]
  def change
    remove_column :branches, :leaders_url
  end
end
