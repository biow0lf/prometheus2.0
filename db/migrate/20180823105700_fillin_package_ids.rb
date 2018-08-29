class FillinPackageIds < ActiveRecord::Migration[5.2]
   def change
      add_index :packages, :type

      add_reference :changelogs, :package, foreign_key: { on_delete: :restrict }, comment: "Ссылка на пакет"
      add_reference :gears, :package, foreign_key: { on_delete: :restrict }, comment: "Ссылка на пакет"
      add_reference :patches, :package, foreign_key: { on_delete: :restrict }, comment: "Ссылка на пакет"
      add_reference :sources, :package, foreign_key: { on_delete: :restrict }, comment: "Ссылка на пакет"
      add_reference :specfiles, :package, foreign_key: { on_delete: :restrict }, comment: "Ссылка на пакет"

      reversible do |dir|
         dir.up do
            sql = <<-SQL
               SQL
            [
                 "UPDATE changelogs
                     SET package_id = packages.id
                    FROM packages
                   WHERE packages.type = 'Package::Src'
                     AND changelogs.srpm_id = packages._src_id",
                 "UPDATE gears
                     SET package_id = packages.id
                    FROM packages
                   WHERE packages.type = 'Package::Src'
                     AND gears.srpm_id = packages._src_id",
                 "UPDATE patches
                     SET package_id = packages.id
                    FROM packages
                   WHERE packages.type = 'Package::Src'
                     AND patches.srpm_id = packages._src_id",
                 "UPDATE sources
                     SET package_id = packages.id
                    FROM packages
                   WHERE packages.type = 'Package::Src'
                     AND sources.srpm_id = packages._src_id",
                 "UPDATE specfiles
                     SET package_id = packages.id
                    FROM packages
                   WHERE packages.type = 'Package::Src'
                     AND specfiles.srpm_id = packages._src_id",
            ].each { |q| Branch.connection.execute(q) }
         end
      end
   end
end
