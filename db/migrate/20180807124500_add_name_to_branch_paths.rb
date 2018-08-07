class AddNameToBranchPaths < ActiveRecord::Migration[5.1]
  def change
    change_table :branch_paths do |t|
      t.string :name, comment: "Имя пути ветви"

      t.index :name
    end
  end
end
