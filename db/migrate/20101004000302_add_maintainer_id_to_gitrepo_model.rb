class AddMaintainerIdToGitrepoModel < ActiveRecord::Migration
  def change
    add_column :gitrepos, :maintainer_id, :integer
    add_index :gitrepos, :maintainer_id
  end
end
