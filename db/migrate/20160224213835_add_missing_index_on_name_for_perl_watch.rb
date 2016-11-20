class AddMissingIndexOnNameForPerlWatch < ActiveRecord::Migration[4.2]
  def change
    add_index :perl_watches, :name
  end
end
