class AddMissingIndexes < ActiveRecord::Migration
  def up
    add_index :acls, :branch_id
    add_index :groups, :branch_id
    add_index :leaders, :branch_id
    add_index :packages, :srpm_id
    add_index :packages, :branch_id
    add_index :srpms, :branch_id
    add_index :teams, :branch_id
  end

  def down
    remove_index :acls, :branch_id
    remove_index :groups, :branch_id
    remove_index :leaders, :branch_id
    remove_index :packages, :srpm_id
    remove_index :packages, :branch_id
    remove_index :srpms, :branch_id
    remove_index :teams, :branch_id
  end
end