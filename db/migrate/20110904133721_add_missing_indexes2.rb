# encoding: utf-8

class AddMissingIndexes2 < ActiveRecord::Migration
  def up
    add_index :conflicts, :package_id
    add_index :obsoletes, :package_id
    add_index :provides, :package_id
    add_index :requires, :package_id
    add_index :ftbfs, :branch_id
    add_index :ftbfs, :maintainer_id
    add_index :groups, :parent_id
    add_index :mirrors, :branch_id
    add_index :srpms, :specfile_id
  end

  def down
    remove_index :conflicts, :package_id
    remove_index :obsoletes, :package_id
    remove_index :provides, :package_id
    remove_index :requires, :package_id
    remove_index :ftbfs, :branch_id
    remove_index :ftbfs, :maintainer_id
    remove_index :groups, :parent_id
    remove_index :mirrors, :branch_id
    remove_index :srpms, :specfile_id
  end
end
