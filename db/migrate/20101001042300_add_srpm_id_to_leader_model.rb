class AddSrpmIdToLeaderModel < ActiveRecord::Migration[4.2]
  def change
    add_column :leaders, :srpm_id, :integer
    add_index :leaders, :srpm_id
    remove_column :leaders, :package, :string
    add_column :leaders, :packager_id, :integer
    add_index :leaders, :packager_id
  end
end
