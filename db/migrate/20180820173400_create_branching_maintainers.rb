class CreateBranchingMaintainers < ActiveRecord::Migration[5.1]
   def change
      create_table :branching_maintainers do |t|
         t.references :branch
         t.references :maintainer
         t.integer :srpms_count, null: false, default: 0, comment: "Счётчик уникальных исходных пакетов, собранных поставщиком для ветви"
      end

      reversible do |dir|
         dir.up do
            Maintainer.find_each do |maintainer|
               maintainer.branches.each do |branch|
                  srpms_count = maintainer.srpm_names.joins(:branch_path).where(branch_paths: { branch_id: branch }).count
                  BranchingMaintainer.create!(maintainer: maintainer, branch: branch, srpms_count: srpms_count)
               end
            end
         end
      end
   end
end
