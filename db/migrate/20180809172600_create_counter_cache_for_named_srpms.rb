class CreateCounterCacheForNamedSrpms < ActiveRecord::Migration[5.1]
   def change
      change_table :branches do |t|
         t.integer :srpms_count, comment: "Счётчик уникальных исходных пакетов для ветви"
      end

      change_table :branch_paths do |t|
         t.integer :srpms_count, comment: "Счётчик именованных исходных пакетов для пути ветви"
      end

      reversible do |dir|
         dir.up do
            BranchPath.all.each { |bp| BranchPath.reset_counters(bp.id, :srpms) }
            Branch.all.each { |b| Branch.reset_counters(b.id, :srpms) }
         end
      end
  end
end
