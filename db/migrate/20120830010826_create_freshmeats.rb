class CreateFreshmeats < ActiveRecord::Migration[4.2]
  def change
    create_table :freshmeats do |t|
      t.string :name
      t.string :version

      t.timestamps
    end
  end
end
