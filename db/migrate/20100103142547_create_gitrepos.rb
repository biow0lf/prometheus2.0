class CreateGitrepos < ActiveRecord::Migration
  def self.up
    create_table :gitrepos do |t|
      t.string :repo
      t.string :login
      t.datetime :lastchange

      t.timestamps
    end
  end

  def self.down
    drop_table :gitrepos
  end
end
