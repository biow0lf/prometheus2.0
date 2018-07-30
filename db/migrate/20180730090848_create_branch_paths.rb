class CreateBranchPaths < ActiveRecord::Migration[5.1]
  def change
    create_table :branch_paths do |t|
      t.string :arch, comment: "Архитектура, используемая для ветви"
      t.string :path, comment: "Путь ко хранилищу rpm-пакетов для архитектуры"
      t.references :branch, foreign_key: true, null: false

      t.timestamps

      t.index %i(arch), using: :gin
      t.index %i(path), using: :gin
      t.index %i(branch_id arch), unique: true
      t.index %i(arch path), unique: true
    end
  end
end
