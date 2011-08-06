class CreateObsoletes < ActiveRecord::Migration
  def up
    create_table :obsoletes do |t|
      t.integer :package_id
      t.string :name
      t.string :type
      t.string :version
      t.string :release

      t.timestamps
    end
  end

  def down
    drop_table :obsoletes
  end
end
