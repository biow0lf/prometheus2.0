class UpdateProvideModel < ActiveRecord::Migration[4.2]
  def change
    remove_column :provides, :type
    add_column :provides, :epoch, :string
    add_column :provides, :flags, :integer
  end
end
