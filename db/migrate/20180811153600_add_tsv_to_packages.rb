class AddTsvToPackages < ActiveRecord::Migration[5.1]
   def change
      change_table :packages do |t|
         t.tsvector :tsv

         t.index %i(tsv), using: :gin
      end

      reversible do |dir|
         dir.up do
            queries = [
               "UPDATE packages
                SET tsv = setweight(to_tsvector(coalesce(name,'')), 'A') ||
                          setweight(to_tsvector(coalesce(summary,'')), 'B') ||
                          setweight(to_tsvector(coalesce(description,'')), 'B') ||
                          setweight(to_tsvector(coalesce(filename,'')), 'A') ||
                          setweight(to_tsvector(coalesce(sourcepackage,'')), 'A')",
               "CREATE FUNCTION packages_search_trigger() RETURNS trigger AS $$
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
               "CREATE TRIGGER tsvectorupdate_for_packages BEFORE INSERT OR UPDATE
                ON packages FOR EACH ROW EXECUTE PROCEDURE packages_search_trigger()"
            ]

            queries.each { |q| Srpm.connection.execute(q) }
         end

         dir.down do
            Srpm.connection.execute("DROP FUNCTION packages_search_trigger() CASCADE")
         end
      end
   end
end
