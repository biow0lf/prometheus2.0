class CreateAcls < ActiveRecord::Migration
  def change
    create_table :acls do |t|
      t.string :package
      t.string :login
      t.string :branch
      t.string :vendor

      t.timestamps
    end
  end
end
