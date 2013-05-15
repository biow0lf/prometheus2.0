class ChangeStringToTextInBugsModelForShortDesc < ActiveRecord::Migration
  def change
    remove_column :bugs, :short_desc
    add_column :bugs, :short_desc, :text
  end
end
