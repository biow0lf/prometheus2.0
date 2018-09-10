class AddTsvToSrpms < ActiveRecord::Migration[5.1]
   def change
      change_table :srpms do |t|
         t.tsvector :tsv

         t.index %i(tsv), using: :gin
      end

      reversible do |dir|
         dir.up do
            queries = [
               "UPDATE srpms
                SET tsv = setweight(to_tsvector(coalesce(name,'')), 'A') ||
                          setweight(to_tsvector(coalesce(summary,'')), 'B') ||
                          setweight(to_tsvector(coalesce(description,'')), 'B') ||
                          setweight(to_tsvector(coalesce(url,'')), 'A')",
               "CREATE FUNCTION srpms_search_trigger() RETURNS trigger AS $$
                begin
                   new.tsv :=
                      setweight(to_tsvector(coalesce(new.name,'')), 'A') ||
                      setweight(to_tsvector(coalesce(new.summary,'')), 'B') ||
                      setweight(to_tsvector(coalesce(new.description,'')), 'B') ||
                      setweight(to_tsvector(coalesce(new.url,'')), 'A');
                   return new;
                end
                $$ LANGUAGE plpgsql",
               "CREATE TRIGGER tsvectorupdate_for_srpms BEFORE INSERT OR UPDATE
                ON srpms FOR EACH ROW EXECUTE PROCEDURE srpms_search_trigger()"
            ]

            queries.each { |q| Branch.connection.execute(q) }
         end

         dir.down do
            Branch.connection.execute("DROP FUNCTION srpms_search_trigger() CASCADE")
         end
      end
   end
end
