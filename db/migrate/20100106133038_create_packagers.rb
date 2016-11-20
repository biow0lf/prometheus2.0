class CreatePackagers < ActiveRecord::Migration[4.2]
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
