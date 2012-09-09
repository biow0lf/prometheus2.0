# encoding: utf-8

class DropGroupsTranslation < ActiveRecord::Migration
  def up
    Group.drop_translation_table! :migrate_data => true
  end

  def down
    Group.create_translation_table!({ :name => :string }, { :migrate_data => true })
  end
end
