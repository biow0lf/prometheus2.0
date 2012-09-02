class AddSizeToPatches < ActiveRecord::Migration
  def change
    add_column :patches, :size, :integer
  end
end
