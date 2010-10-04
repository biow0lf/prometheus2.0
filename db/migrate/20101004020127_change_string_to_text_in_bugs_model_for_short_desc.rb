class ChangeStringToTextInBugsModelForShortDesc < ActiveRecord::Migration
  def self.up
    remove_column :bugs, :short_desc
    add_column :bugs, :short_desc, :text
  end

  def self.down
    remove_column :bugs, :short_desc
    add_column :bugs, :short_desc, :string
  end
end