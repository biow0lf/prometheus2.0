class AddMissingIndexOnNameForPerlWatch < ActiveRecord::Migration
  def change
    add_index :perl_watches, :name
  end
end
