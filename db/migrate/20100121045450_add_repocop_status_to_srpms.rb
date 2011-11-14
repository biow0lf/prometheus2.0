# encoding: utf-8

class AddRepocopStatusToSrpms < ActiveRecord::Migration
  def up
    add_column :srpms, :repocop, :string, :default => 'skip'
  end

  def down
    remove_column :srpms, :repocop
  end
end
