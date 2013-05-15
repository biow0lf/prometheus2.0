class AddMissingIndexes < ActiveRecord::Migration
  def change
    add_index :acls, :branch_id
    add_index :groups, :branch_id
    add_index :leaders, :branch_id
    add_index :packages, :srpm_id
    add_index :packages, :branch_id
    add_index :srpms, :branch_id
    add_index :teams, :branch_id
  end
end
