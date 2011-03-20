class UpdateConflictsModel < ActiveRecord::Migration
  def self.up
    remove_column :conflicts, :type
    add_column :conflicts, :epoch, :string
    add_column :conflicts, :flags, :integer
  end

  def self.down
    add_column :conflicts, :type, :string
    remove_column :conflicts, :epoch
    remove_column :conflicts, :flags
  end
end
