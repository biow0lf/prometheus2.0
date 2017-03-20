class UpdateConflictsModel < ActiveRecord::Migration[4.2]
  def change
    remove_column :conflicts, :type, :string
    add_column :conflicts, :epoch, :string
    add_column :conflicts, :flags, :integer
  end
end
