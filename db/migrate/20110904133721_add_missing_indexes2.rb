class AddMissingIndexes2 < ActiveRecord::Migration
  def change
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
end
