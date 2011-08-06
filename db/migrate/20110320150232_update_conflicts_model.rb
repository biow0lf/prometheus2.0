class UpdateConflictsModel < ActiveRecord::Migration
  def up
    remove_column :conflicts, :type
    add_column :conflicts, :epoch, :string
    add_column :conflicts, :flags, :integer
  end

  def down
    add_column :conflicts, :type, :string
    remove_column :conflicts, :epoch
    remove_column :conflicts, :flags
  end
end
