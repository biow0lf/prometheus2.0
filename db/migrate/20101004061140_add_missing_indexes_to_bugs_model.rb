class AddMissingIndexesToBugsModel < ActiveRecord::Migration[4.2]
  def change
    add_index :bugs, :assigned_to
    add_index :bugs, :product
    add_index :bugs, :bug_status
  end
end
