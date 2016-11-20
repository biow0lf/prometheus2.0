class AddFlagsToRequires < ActiveRecord::Migration[4.2]
  def change
    add_column :requires, :flags, :integer
  end
end
