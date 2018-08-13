class AddImportedAtToBranchPaths < ActiveRecord::Migration[5.1]
   def change
      change_table :branch_paths do |t|
         t.datetime :imported_at, null: false, default: Time.at(0), comment: "Время последнего импорта пакетов для пути ветви"
      end
   end
end
