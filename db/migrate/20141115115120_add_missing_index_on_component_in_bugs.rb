class AddMissingIndexOnComponentInBugs < ActiveRecord::Migration
  def change
    add_index :bugs, :component
  end
end
