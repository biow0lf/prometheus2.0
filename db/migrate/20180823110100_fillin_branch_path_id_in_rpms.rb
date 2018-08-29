class FillinBranchPathIdInRpms < ActiveRecord::Migration[5.2]
   def change
      add_column :rpms, :arch, :string
      remove_index :rpms, columns: ["branch_path_id", "filename"], name: "index_rpms_on_branch_path_id_and_filename", unique: true

      reversible do |dir|
         dir.up do
            [
                 "UPDATE rpms
                     SET arch = packages.arch
                    FROM packages
                   WHERE packages.id = rpms.package_id"
            ].each { |q| Branch.connection.execute(q) }

            table = {
               "S1" => 'Sisyphus .*',
               "M51" => '5.1 .*',
               "M50P" => 'p5 .*',
               "M60P" => 'p6 .*',
               "M70P" => 'p7 .*',
               "M80P" => 'p8 .*',
               "M60C" => 'c6 .*',
               "M70C" => 'c7 .*',
               "M80C" => 'c8 .*',
               "M60T" => 't6 .*',
               "M70T" => 't7 .*',
            }.reduce({}) do |res, (s, re)|
               res[s] ||= {}
               res[s] = BranchPath.where("name ~* '#{re}'").map { |bp| [bp.arch, [bp.id]] }.to_h
               res
            end

            Rpm.where(branch_path_id: nil).all.each do |rpm|
               if suffix = rpm.filename.split('-').last.split('.')[1...-2].select { |s| table.keys.include?(s) }.first
                  if table[suffix][rpm.arch]
                     table[suffix][rpm.arch] << rpm.id
                  end
               end
            end

            table.each_value do |arches|
               arches.each do |(arch, ids)|
                  bp_id = ids.shift

                  Rpm.where(id: ids).update(branch_path_id: bp_id)
               end
            end

            Rpm.where(branch_path_id: nil).delete_all

            queries = [
              "DELETE
                 FROM rpms a
                USING rpms b
                WHERE a.id < b.id
                  AND a.branch_path_id = b.branch_path_id
                  AND a.filename = b.filename"
            ]

            queries.each { |q| Branch.connection.execute(q) }
         end
      end


      remove_column :rpms, :arch, type: :string
      add_index :rpms, ["branch_path_id", "filename"], name: "index_rpms_on_branch_path_id_and_filename", unique: true

      change_column_null :rpms, :branch_path_id, false
   end
end
