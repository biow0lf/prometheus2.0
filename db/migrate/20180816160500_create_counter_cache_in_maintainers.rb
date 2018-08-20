class CreateCounterCacheInMaintainers < ActiveRecord::Migration[5.1]
   def change
      change_table :maintainers do |t|
         t.integer :srpms_count, default: 0, comment: "Счётчик уникальных исходных пакетов, собранных поставщиком"
      end

      reversible do |dir|
         dir.up do
            Maintainer.find_each { |m| Maintainer.reset_counters(m.id, :srpms) }
         end
      end
   end
end
