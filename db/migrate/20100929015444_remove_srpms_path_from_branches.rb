class RemoveSrpmsPathFromBranches < ActiveRecord::Migration[4.2]
  def change
    remove_column :branches, :srpms_path
  end
end
