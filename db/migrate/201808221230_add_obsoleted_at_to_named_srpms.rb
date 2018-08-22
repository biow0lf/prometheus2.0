class AddObsoletedAtToNamedSrpms < ActiveRecord::Migration[5.1]
   def change
      change_table :named_srpms do |t|
         t.datetime :obsoleted_at, index: true, comment: "Время устаревания пакета, если установлено, то пакет более не находится в ветви"
      end
   end
end
