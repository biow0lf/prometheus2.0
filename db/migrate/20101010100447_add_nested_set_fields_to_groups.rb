class AddNestedSetFieldsToGroups < ActiveRecord::Migration[4.2]
  def change
    add_column :groups, :parent_id, :integer
    add_column :groups, :lft, :integer
    add_column :groups, :rgt, :integer
  end
end
