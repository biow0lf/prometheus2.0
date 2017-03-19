class CleanGroupModel < ActiveRecord::Migration[4.2]
  def change
    remove_column :groups, :branch, :string
    remove_column :groups, :vendor, :string
  end
end
