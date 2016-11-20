class AddSizeToPatches < ActiveRecord::Migration[4.2]
  def change
    add_column :patches, :size, :integer
  end
end
