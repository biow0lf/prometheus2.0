class UpdateCounterCacheForNamedSrpms < ActiveRecord::Migration[5.1]
   def change
      change_column_default(:branches, :srpms_count, 0)
      change_column_default(:branch_paths, :srpms_count, 0)

      reversible do |dir|
         dir.up do
            BranchPath.all.each { |bp| BranchPath.reset_counters(bp.id, :srpms) }
            Branch.all.each { |b| Branch.reset_counters(b.id, :srpms) }
         end
      end
  end
end
