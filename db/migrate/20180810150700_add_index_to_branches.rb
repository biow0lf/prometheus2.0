class AddIndexToBranches < ActiveRecord::Migration[5.1]
   def change
      add_index :branches, :name
   end
end
