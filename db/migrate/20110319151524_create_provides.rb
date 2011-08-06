class CreateProvides < ActiveRecord::Migration
  def up
    create_table :provides do |t|
      t.integer :package_id
      t.string :name
      t.string :type
      t.string :version
      t.string :release

      t.timestamps
    end
  end

  def down
    drop_table :provides
  end
end
