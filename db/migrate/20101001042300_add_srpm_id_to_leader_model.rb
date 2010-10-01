class AddSrpmIdToLeaderModel < ActiveRecord::Migration
  def self.up
    add_column :leaders, :srpm_id, :integer
    add_index :leaders, :srpm_id
    remove_column :leaders, :package
    add_column :leaders, :packager_id, :integer
    add_index :leaders, :packager_id
  end

  def self.down
    remove_index :leaders, :packager_id
    remove_column :leaders, :packager_id
    add_column :leaders, :package, :string
    remove_index :leaders, :srpm_id
    remove_column :leaders, :srpm_id
  end
end