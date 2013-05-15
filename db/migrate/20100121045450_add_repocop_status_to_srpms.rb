class AddRepocopStatusToSrpms < ActiveRecord::Migration
  def change
    add_column :srpms, :repocop, :string, :default => 'skip'
  end
end
