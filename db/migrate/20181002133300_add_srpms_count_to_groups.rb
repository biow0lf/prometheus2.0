class AddSrpmsCountToGroups < ActiveRecord::Migration[5.2]
   def change
      change_table :groups do |t|
         t.integer :srpms_count, default: 0, comment: "Счётчик именованных исходных пакетов для группы"
      end

      reversible do |dir|
         dir.up do
            Group.find_each do |group|
               group.update!(srpms_count: group.srpms.count)
            end
         end
      end
   end
end
