class CreateNamedSrpms < ActiveRecord::Migration[5.1]
   def change
      enable_extension :btree_gin

      create_table :named_srpms do |t|
         t.belongs_to :branch, foreign_key: true, null: false, comment: "Отошение к ветви"
         t.belongs_to :srpm, foreign_key: true, null: false, comment: "Отношение к содержимому srpm"
         t.string :name, null: false, comment: "Имя файла srpm, такое, как он представлен в заданной ветви"

         t.timestamps

         t.index %i(branch_id srpm_id), unique: true
         t.index %i(branch_id name), unique: true
         t.index :name, using: :gin
      end

      reversible do |dir|
         dir.up do
            NamedSrpm.class_eval do
               def filename= value
                  self.name = value
               end
            end

            srpms = Srpm.where.not(branch_id: nil).select(:branch_id, :filename)
            attrs = srpms.as_json.map { |x| x.merge(name: x.delete("filename")) }
            NamedSrpm.import(attrs)
         end
      end

      remove_column :srpms, :branch_id, :integer
      remove_column :srpms, :filename, :string
      remove_column :srpms, :alias, :string
   end
end
