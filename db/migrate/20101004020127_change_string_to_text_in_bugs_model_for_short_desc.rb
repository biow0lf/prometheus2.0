class ChangeStringToTextInBugsModelForShortDesc < ActiveRecord::Migration[4.2]
  def change
    remove_column :bugs, :short_desc, :string
    add_column :bugs, :short_desc, :text
  end
end
