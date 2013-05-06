class AddSrpmIdToGitrepoModel < ActiveRecord::Migration
  def change
    add_column :gitrepos, :srpm_id, :integer
    add_index :gitrepos, :srpm_id
    remove_column :gitrepos, :login
  end
end
