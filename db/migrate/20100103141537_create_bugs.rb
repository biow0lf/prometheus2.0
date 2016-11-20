# rubocop:disable Metrics/MethodLength
class CreateBugs < ActiveRecord::Migration[4.2]
  def change
    create_table :bugs do |t|
      t.integer :bug_id
      t.string :bug_status
      t.string :resolution
      t.string :bug_severity
      t.string :product
      t.string :component
      t.string :assigned_to
      t.string :reporter
      t.string :short_desc

      t.timestamps
    end
  end
end
