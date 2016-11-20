class CreateLeaders < ActiveRecord::Migration[4.2]
  def change
    create_table :leaders do |t|
      t.string :package
      t.string :login
      t.string :branch

      t.timestamps
    end
  end
end
