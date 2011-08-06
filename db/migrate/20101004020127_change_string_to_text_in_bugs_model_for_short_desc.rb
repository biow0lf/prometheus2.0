class ChangeStringToTextInBugsModelForShortDesc < ActiveRecord::Migration
  def up
    remove_column :bugs, :short_desc
    add_column :bugs, :short_desc, :text
  end

  def down
    remove_column :bugs, :short_desc
    add_column :bugs, :short_desc, :string
  end
end