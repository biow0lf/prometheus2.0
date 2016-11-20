class AddRepocopStatusToSrpms < ActiveRecord::Migration[4.2]
  def change
    add_column :srpms, :repocop, :string, default: 'skip'
  end
end
