class RemoveLeadersUrlFromBranches < ActiveRecord::Migration
  def change
    remove_column :branches, :leaders_url
  end
end
