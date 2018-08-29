class MergePackagesAndSrpms < ActiveRecord::Migration[5.2]
   def change
      reversible do |dir|
         dir.down do
           add_foreign_key :packages, :srpms, on_delete: :cascade
           add_foreign_key :named_srpms, to_table: :srpms, on_delete: :cascade
         end

         dir.down do
            queries = [
               "DROP FUNCTION IF EXISTS packages_fillin_src_id() CASCADE",
               "UPDATE packages
                SET tsv = setweight(to_tsvector(coalesce(name,'')), 'A') ||
                          setweight(to_tsvector(coalesce(summary,'')), 'B') ||
                          setweight(to_tsvector(coalesce(description,'')), 'B') ||
                          setweight(to_tsvector(coalesce(filename,'')), 'A') ||
                          setweight(to_tsvector(coalesce(sourcepackage,'')), 'A')",
               "CREATE OR REPLACE FUNCTION packages_search_trigger() RETURNS trigger AS $$
                begin
                   new.tsv :=
                      setweight(to_tsvector(coalesce(new.name,'')), 'A') ||
                      setweight(to_tsvector(coalesce(new.summary,'')), 'B') ||
                      setweight(to_tsvector(coalesce(new.description,'')), 'B') ||
                      setweight(to_tsvector(coalesce(new.filename,'')), 'A') ||
                      setweight(to_tsvector(coalesce(new.sourcepackage,'')), 'A');
                   return new;
                end
                $$ LANGUAGE plpgsql",
            ]

            queries.each { |q| Branch.connection.execute(q) }
         end

#         dir.up do
#            # dedup
#            queries = [
#              "DELETE
#                 FROM changelogs a
#                USING changelogs b
#                WHERE a.id < b.id
#                  AND a.changelogtime = b.changelogtime
#                  AND a.changelogname = b.changelogname
#                  AND a.changelogtext = b.changelogtext"
#            ]
#
##            queries.each { |q| Branch.connection.execute(q) }
#         end
      end
      
      change_table :packages do |t|
         t.string :repocop, default: 'skip', comment: "Статус проверки репокопом"
         t.string :vendor, comment: "Распространитель пакета"
         t.string :distribution, comment: "Срез набора пакетов"
         t.string :buildhost, comment: "Место сборки пакета"
         t.string :type, comment: "Вид пакета: исходник или двояк"
         t.references :builder, foreign_key: { to_table: :maintainers, on_delete: :restrict }, comment: "Собиратель пакета"
         t.integer :src_id, index: true, foreign_key: { to_table: :packages, on_delete: :restrict }, comment: "Ссылка на исходный пакет, может указывать на самого себя"
         t.integer :_src_id
      end

      add_reference :changelogs, :package, foreign_key: { on_delete: :restrict }, comment: "Ссылка на пакет"
      add_reference :gears, :package, foreign_key: { on_delete: :restrict }, comment: "Ссылка на пакет"
      add_reference :patches, :package, foreign_key: { on_delete: :restrict }, comment: "Ссылка на пакет"
      add_reference :sources, :package, foreign_key: { on_delete: :restrict }, comment: "Ссылка на пакет"
      add_reference :specfiles, :package, foreign_key: { on_delete: :restrict }, comment: "Ссылка на пакет"
      add_reference :named_srpms, :package, foreign_key: { on_delete: :cascade }, comment: "Ссылка на пакет"
      add_index :changelogs, %i(changelogtime changelogname package_id), unique: true, name: :three_in_one_index
      change_column_null :named_srpms, :branch_path_id, true
      change_column_null :named_srpms, :srpm_id, true

      reversible do |dir|
         dir.up do
           remove_foreign_key :named_srpms, to_table: :srpms, on_delete: :cascade
           remove_foreign_key :packages, to_table: :srpms, on_delete: :cascade
         end

         dir.up do
            queries = [
               "UPDATE packages
                SET tsv = setweight(to_tsvector(coalesce(name,'')), 'A') ||
                          setweight(to_tsvector(coalesce(summary,'')), 'B') ||
                          setweight(to_tsvector(coalesce(description,'')), 'C') ||
                          setweight(to_tsvector(coalesce(url,'')), 'D')",
               "CREATE OR REPLACE FUNCTION packages_search_trigger() RETURNS trigger AS $$
                begin
                   new.tsv :=
                      setweight(to_tsvector(coalesce(new.name,'')), 'A') ||
                      setweight(to_tsvector(coalesce(new.summary,'')), 'B') ||
                      setweight(to_tsvector(coalesce(new.description,'')), 'C') ||
                      setweight(to_tsvector(coalesce(new.url,'')), 'D');
                   return new;
                end
                $$ LANGUAGE plpgsql",
               "CREATE OR REPLACE FUNCTION packages_fillin_src_id() RETURNS trigger AS $$
                begin
                   new.src_id := new.id;
                   return new;
                end
                $$ LANGUAGE plpgsql",
               "CREATE TRIGGER packages_fillin_src_id_trigger BEFORE INSERT
                ON packages FOR EACH ROW EXECUTE PROCEDURE packages_fillin_src_id()"
            ]

            queries.each { |q| Branch.connection.execute(q) }
         end

         dir.up do
            sql = <<-SQL
                  INSERT INTO packages
                             (name, version, release, summary, license, url, description, buildtime, created_at, updated_at,
                              repocop, group_id, vendor, distribution, md5, builder_id, groupname, size, epoch, buildhost,
                              _src_id, type, arch)
                       SELECT name, version, release, summary, license, url, description, buildtime, created_at, updated_at,
                              repocop, group_id, vendor, distribution, md5, builder_id, groupname, size, epoch, buildhost,
                              id, 'Package::Src', 'src'
                         FROM srpms
               SQL
            Package.connection.execute(sql)
#      binding.pry
            sql = <<-SQL
                  UPDATE packages AS a
                     SET src_id = b.id
                    FROM packages AS b
                   WHERE a.srpm_id = b._src_id
               SQL
            Package.connection.execute(sql)
#      binding.pry

            sql = <<-SQL
                  INSERT INTO changelogs
                             (changelogtime, changelogname, changelogtext, created_at, updated_at, delta)
                       SELECT changelogtime, changelogname, changelogtext, created_at, updated_at, delta
                         FROM srpms
                ON CONSTRAINT three_in_one_index
                DO UPDATE SET delta = srpms.delta
               SQL
#      binding.pry
#       Changelog.from(:package).where("packages.type = 'Package::Src' AND changelogs.srpm_id = packages._src_id").update_all("changelogs.package_id = packages.id")
#       Changelog.joins(:package).where("packages.type = 'Package::Src' AND changelogs.srpm_id = packages._src_id").update_all("changelogs.package_id = packages.id")
#            Gear.joins(:package).where("packages.type = 'Package::Src' AND gears.srpm_id = packages._src_id").update_all("gears.package_id = packages.id")
#           Patch.joins(:package).where("packages.type = 'Package::Src' AND patches.srpm_id = packages._src_id").update_all("patches.package_id = packages.id")
#          Source.joins(:package).where("packages.type = 'Package::Src' AND sources.srpm_id = packages._src_id").update_all("sources.package_id = packages.id")
#        Specfile.joins(:package).where("packages.type = 'Package::Src' AND specfiles.srpm_id = packages._src_id").update_all("specfiles.package_id = packages.id")
#      binding.pry
#            Changelog.connection.execute(sql)
            queries = [
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
            ]
            queries.each { |q| Branch.connection.execute(q) }

            sql = <<-SQL
                  INSERT INTO named_srpms
                             (filename, name, package_id, created_at, updated_at)
                       SELECT filename, name, id, created_at, updated_at
                         FROM packages
                        WHERE packages.type IS NULL
               SQL
            Package.connection.execute(sql)
#      binding.pry
#            #TODO fill in branch_path_id for srpms and builder_id for packages
            Package.where(type: nil).update_all(type: "Package::Built")
         end
      end

#      change_column_null :packages, :builder_id, false
      change_column_null :packages, :arch, false
      change_column_null :packages, :type, false
      change_column_null :packages, :src_id, false

      remove_column :packages, :filename, :string
      remove_column :packages, :srpm_id, :integer
      remove_column :packages, :_src_id, :integer
      remove_reference :named_srpms, :srpm, null: false, comment: "Отношение к содержимому srpm"
      remove_reference :changelogs, :srpm
      remove_reference :gears, :srpm
      remove_reference :patches, :srpm
      remove_reference :sources, :srpm
      remove_reference :specfiles, :srpm
      remove_column :packages, :sourcepackage, :string

      drop_table :srpms, id: :serial, force: :cascade do |t|
         t.string "name", limit: 255
         t.string "version", limit: 255
         t.string "release", limit: 255
         t.string "summary", limit: 255
         t.string "license", limit: 255
         t.string "url", limit: 255
         t.text "description"
         t.datetime "buildtime"
         t.datetime "created_at"
         t.datetime "updated_at"
         t.string "repocop", limit: 255, default: "skip"
         t.integer "group_id"
         t.string "vendor", limit: 255
         t.string "distribution", limit: 255
         t.string "changelogname", limit: 255
         t.text "changelogtext"
         t.string "md5", limit: 255, null: false
         t.boolean "delta", default: true, null: false
         t.integer "builder_id"
         t.string "groupname", limit: 255
         t.integer "size"
         t.datetime "changelogtime"
         t.integer "epoch"
         t.string "buildhost"
         t.tsvector "tsv"
         t.index ["group_id"], name: "index_srpms_on_group_id"
         t.index ["md5"], name: "index_srpms_on_md5", unique: true
         t.index ["name"], name: "index_srpms_on_name"
         t.index ["tsv"], name: "index_srpms_on_tsv", using: :gin
      end

      rename_table :named_srpms, :rpms

      add_index :rpms, %i(branch_path_id package_id), unique: true

      a = true
      binding.pry
      raise if a
   end
end
