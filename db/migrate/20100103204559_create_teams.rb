class CreateTeams < ActiveRecord::Migration[4.2]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :login
      t.string :branch
      t.boolean :leader

      t.timestamps
    end
  end
end
