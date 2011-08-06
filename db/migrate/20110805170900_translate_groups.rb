class TranslateGroups < ActiveRecord::Migration
  def up
    Group.create_translation_table!({ :name => :string }, { :migrate_data => true })
  end

  def down
    Group.drop_translation_table! :migrate_data => true
  end
end
