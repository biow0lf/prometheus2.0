class UpdateConflictsModel < ActiveRecord::Migration
  def change
    remove_column :conflicts, :type
    add_column :conflicts, :epoch, :string
    add_column :conflicts, :flags, :integer
  end
end
