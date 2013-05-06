class AddFlagsToRequires < ActiveRecord::Migration
  def change
    add_column :requires, :flags, :integer
  end
end
