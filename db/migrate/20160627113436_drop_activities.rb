class DropActivities < ActiveRecord::Migration[5.0]
  def change
    remove_index :activities, [:trackable_id, :trackable_type]
    remove_index :activities, [:owner_id, :owner_type]
    remove_index :activities, [:recipient_id, :recipient_type]

    drop_table :activities
  end
end
