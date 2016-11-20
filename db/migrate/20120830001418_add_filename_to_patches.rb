class AddFilenameToPatches < ActiveRecord::Migration[4.2]
  def change
    add_column :patches, :filename, :string
  end
end
