class CreateFreshmeats < ActiveRecord::Migration
  def change
    create_table :freshmeats do |t|
      t.string :name
      t.string :version

      t.timestamps
    end
  end
end
