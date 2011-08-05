class AddTranslationTableForGroups < ActiveRecord::Migration
  def self.up
    Group.create_translation_table!({ :name => :string }, { :migrate_data => true })
  end

  def self.down
    Group.drop_translation_table! :migrate_data => true
  end
end
