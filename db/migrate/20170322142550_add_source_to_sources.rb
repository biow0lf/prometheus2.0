class AddSourceToSources < ActiveRecord::Migration[5.0]
  def change
    add_column :sources, :source, :boolean
  end
end
