class ExtendPackages < ActiveRecord::Migration[5.2]
   def change
      reversible do |dir|
         dir.down do
            add_foreign_key :packages, :srpms, on_delete: :cascade

            [
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
            ].each { |q| Branch.connection.execute(q) }
         end
      end

      change_table :packages do |t|
         t.string :repocop, default: 'skip', comment: "Статус проверки репокопом"
         t.string :vendor, comment: "Распространитель пакета"
         t.string :distribution, comment: "Срез набора пакетов"
         t.string :buildhost, comment: "Место сборки пакета"
         t.string :type, index: true, comment: "Вид пакета: исходник или двояк"
         t.references :builder, foreign_key: { to_table: :maintainers, on_delete: :restrict }, comment: "Собиратель пакета"
         t.integer :src_id, index: true, foreign_key: { to_table: :packages, on_delete: :restrict }, comment: "Ссылка на исходный пакет, может указывать на самого себя"
         t.integer :_src_id
      end

      reversible do |dir|
         dir.up do
            remove_foreign_key :packages, to_table: :srpms, on_delete: :cascade
         end

         dir.up do
            [
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
                ON packages FOR EACH ROW EXECUTE PROCEDURE packages_fillin_src_id()",
               "  INSERT INTO packages
                             (name, version, release, summary, license, url, description, buildtime, created_at, updated_at,
                              repocop, group_id, vendor, distribution, md5, builder_id, groupname, size, epoch, buildhost,
                              _src_id, type, arch)
                       SELECT name, version, release, summary, license, url, description, buildtime, created_at, updated_at,
                              repocop, group_id, vendor, distribution, md5, builder_id, groupname, size, epoch, buildhost,
                              id, 'Package::Src', 'src'
                         FROM srpms",
            ].each { |q| Branch.connection.execute(q) }

            Package.where(type: nil).update_all(type: "Package::Built")
         end

         dir.down do
            [
               "  DELETE FROM packages
                        WHERE type = 'Package::Src'"
            ].each { |q| Branch.connection.execute(q) }
         end
      end

      change_column_null :packages, :arch, false
      change_column_null :packages, :type, false
   end
end
