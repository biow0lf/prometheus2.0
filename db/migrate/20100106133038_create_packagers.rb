class CreatePackagers < ActiveRecord::Migration
  def change
    create_table :packagers do |t|
      t.string :name
      t.string :email
      t.string :login
      t.boolean :team

      t.timestamps
    end
  end
end
