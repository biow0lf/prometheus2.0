class LinkChildrenPackages < ActiveRecord::Migration[5.2]
   def change
      reversible do |dir|
         dir.up do
            [
                 "UPDATE packages AS pkgs
                     SET src_id = spkgs.id
                    FROM packages AS spkgs
                   WHERE pkgs.srpm_id = spkgs._src_id"
            ].each { |q| Branch.connection.execute(q) }
         end
      end

      change_column_null :packages, :src_id, false
   end
end
