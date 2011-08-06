class RemoveTypeFromRequires < ActiveRecord::Migration
  def up
    remove_column :requires, :type
  end

  def down
    add_column :requires, :type, :string
  end
end
