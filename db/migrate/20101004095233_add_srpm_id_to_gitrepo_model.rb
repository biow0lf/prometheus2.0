class AddSrpmIdToGitrepoModel < ActiveRecord::Migration[4.2]
  def change
    add_column :gitrepos, :srpm_id, :integer
    add_index :gitrepos, :srpm_id
    remove_column :gitrepos, :login, :string
  end
end
