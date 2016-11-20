class AddDeltaToChangelog < ActiveRecord::Migration[4.2]
  def change
    add_column :changelogs, :delta, :boolean, default: true, null: false
  end
end
