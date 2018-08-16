class UpdateCounterCacheForNamedSrpms < ActiveRecord::Migration[5.1]
   def change
      change_column_default(:branches, :srpms_count, 0)
      change_column_default(:branch_paths, :srpms_count, 0)

      reversible do |dir|
         dir.up do
            BranchPath.all.each { |bp| bp.update(srpms_count: bp.named_srpms.count) }
            Branch.all.each { |b| b.update(srpms_count: b.named_srpms.count) }
         end
      end
  end
end
