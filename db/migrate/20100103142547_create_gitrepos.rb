class CreateGitrepos < ActiveRecord::Migration[4.2]
  def change
    create_table :gitrepos do |t|
      t.string :repo
      t.string :login
      t.datetime :lastchange

      t.timestamps
    end
  end
end
