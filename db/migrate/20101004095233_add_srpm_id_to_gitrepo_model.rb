# encoding: utf-8

class AddSrpmIdToGitrepoModel < ActiveRecord::Migration
  def up
    add_column :gitrepos, :srpm_id, :integer
    add_index :gitrepos, :srpm_id
    remove_column :gitrepos, :login
  end

  def down
    add_column :gitrepos, :login
    remove_index :gitrepos, :srpm_id
    remove_column :gitrepos, :srpm_id
  end
end
