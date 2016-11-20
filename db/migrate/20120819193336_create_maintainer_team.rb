class CreateMaintainerTeam < ActiveRecord::Migration[4.2]
  def change
    create_table :maintainer_teams do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :login, null: false

      t.timestamps
    end
  end
end
