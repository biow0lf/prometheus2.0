class CleanupPackagesEtc < ActiveRecord::Migration[5.2]
   def change
      remove_column :packages, :filename, :string
      remove_column :packages, :srpm_id, :integer
      remove_column :packages, :_src_id, :integer
      remove_column :packages, :sourcepackage, :string

      remove_reference :changelogs, :srpm
      remove_reference :gears, :srpm
      remove_reference :patches, :srpm
      remove_reference :sources, :srpm
      remove_reference :specfiles, :srpm

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
   end
end
