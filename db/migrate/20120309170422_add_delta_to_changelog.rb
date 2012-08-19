# encoding: utf-8

class AddDeltaToChangelog < ActiveRecord::Migration
  def change
    add_column :changelogs, :delta, :boolean, :default => true, :null => false
  end
end
