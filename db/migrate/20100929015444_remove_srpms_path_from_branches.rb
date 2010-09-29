class RemoveSrpmsPathFromBranches < ActiveRecord::Migration
  def self.up
    remove_column :branches, :srpms_path
  end

  def self.down
    add_column :branches, :srpms_path, :string
  end
end