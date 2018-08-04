# frozen_string_literal: true

class AddArchivedToPlatforms < ActiveRecord::Migration[5.1]
  def change
    add_column :platforms, :archived, :boolean, default: false
  end
end
