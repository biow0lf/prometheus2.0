class RemoveSrpmsPathFromBranches < ActiveRecord::Migration
  def change
    remove_column :branches, :srpms_path
  end
end
