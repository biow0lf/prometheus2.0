class AddActiveToBranchPaths < ActiveRecord::Migration[5.1]
  def change
    change_table :branch_paths do |t|
      t.boolean :active, default: true, comment: "Флаг задействования пути ветви, если установлен, то путь активен"
    end
  end
end
