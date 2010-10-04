class AddMissingIndexesToBugsModel < ActiveRecord::Migration
  def self.up
    add_index :bugs, :assigned_to
    add_index :bugs, :product
    add_index :bugs, :bug_status
  end

  def self.down
    remove_index :bugs, :assigned_to
    remove_index :bugs, :product
    remove_index :bugs, :bug_status
  end
end