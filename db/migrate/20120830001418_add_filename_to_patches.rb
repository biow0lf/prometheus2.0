class AddFilenameToPatches < ActiveRecord::Migration
  def change
    add_column :patches, :filename, :string
  end
end
