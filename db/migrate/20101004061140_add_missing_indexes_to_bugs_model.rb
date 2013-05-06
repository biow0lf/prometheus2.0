class AddMissingIndexesToBugsModel < ActiveRecord::Migration
  def change
    add_index :bugs, :assigned_to
    add_index :bugs, :product
    add_index :bugs, :bug_status
  end
end
