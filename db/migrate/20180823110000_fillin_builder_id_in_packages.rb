class FillinBuilderIdInPackages < ActiveRecord::Migration[5.2]
   def change
      reversible do |dir|
         dir.up do
            [
                 "UPDATE packages AS pkgs
                     SET builder_id = spkgs.builder_id
                    FROM packages AS spkgs
                   WHERE pkgs.builder_id IS NULL
                     AND spkgs.id = pkgs.src_id"
            ].each { |q| Branch.connection.execute(q) }
         end
      end

      change_column_null :packages, :builder_id, false
   end
end
