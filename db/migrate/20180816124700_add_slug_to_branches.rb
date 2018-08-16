class AddSlugToBranches < ActiveRecord::Migration[5.1]
   def change
      change_table :branches do |t|
         t.string :slug, comment: "Плашка для обращения к ветви в строке пути браузера"
      end

      reversible do |dir|
         dir.up do
            Branch.find_each { |b| b.update(slug: b.name.gsub('.', '_').downcase ) }
         end
      end

      change_column_null :branches, :slug, false
      add_index :branches, :slug, unique: true
   end
end
