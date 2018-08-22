class AddObsoletedAtToNamedSrpms < ActiveRecord::Migration[5.1]
   def up
      if !column_exists?(:named_srpms, :obsoleted_at)
         add_column :named_srpms, :obsoleted_at, :datetime, index: true, comment: "Время устаревания пакета, если установлено, то пакет более не находится в ветви"
      end
   end

   def down
      if column_exists?(:named_srpms, :obsoleted_at)
         remove_column :named_srpms, :obsoleted_at, :datetime, index: true, comment: "Время устаревания пакета, если установлено, то пакет более не находится в ветви"
      end
   end
end
