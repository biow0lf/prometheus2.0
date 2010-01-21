class AddRepocopStatusToSrpms < ActiveRecord::Migration
  def self.up
    add_column :srpms, :repocop, :string, :default => 'skip'
  end

  def self.down
    remove_column :srpms, :repocop
  end
end
