class RemoveSrpmsPathFromBranches < ActiveRecord::Migration
  def up
    remove_column :branches, :srpms_path
  end

  def down
    add_column :branches, :srpms_path, :string
  end
end