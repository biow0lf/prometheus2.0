# frozen_string_literal: true

class RenameSourcesSourceToContent < ActiveRecord::Migration[5.0]
  def change
    rename_column :sources, :source, :content
  end
end
