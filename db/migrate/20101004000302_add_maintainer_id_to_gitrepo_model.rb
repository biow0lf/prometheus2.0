class AddMaintainerIdToGitrepoModel < ActiveRecord::Migration
  def up
    add_column :gitrepos, :maintainer_id, :integer
    add_index :gitrepos, :maintainer_id
  end

  def down
    remove_index :gitrepos, :maintainer_id
    remove_column :gitrepos, :maintainer_id
  end
end