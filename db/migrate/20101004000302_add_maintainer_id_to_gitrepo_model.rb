class AddMaintainerIdToGitrepoModel < ActiveRecord::Migration
  def self.up
    add_column :gitrepos, :maintainer_id, :integer
    add_index :gitrepos, :maintainer_id
  end

  def self.down
    remove_index :gitrepos, :maintainer_id
    remove_column :gitrepos, :maintainer_id
  end
end