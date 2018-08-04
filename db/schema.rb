# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180804154702) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "architectures", force: :cascade do |t|
    t.bigint "platform_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["platform_id"], name: "index_architectures_on_platform_id"
  end

  create_table "branches", id: :serial, force: :cascade do |t|
    t.string "vendor"
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "order_id"
    t.string "path"
  end

  create_table "bugs", id: :serial, force: :cascade do |t|
    t.integer "bug_id"
    t.string "bug_status"
    t.string "resolution"
    t.string "bug_severity"
    t.string "product"
    t.string "component"
    t.string "assigned_to"
    t.string "reporter"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "short_desc"
    t.index ["assigned_to"], name: "index_bugs_on_assigned_to"
    t.index ["bug_status"], name: "index_bugs_on_bug_status"
    t.index ["component"], name: "index_bugs_on_component"
    t.index ["product"], name: "index_bugs_on_product"
  end

  create_table "changelogs", id: :serial, force: :cascade do |t|
    t.integer "srpm_id"
    t.string "changelogtime"
    t.binary "changelogname"
    t.binary "changelogtext"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "delta", default: true, null: false
    t.index ["srpm_id"], name: "index_changelogs_on_srpm_id"
  end

  create_table "conflicts", id: :serial, force: :cascade do |t|
    t.integer "package_id"
    t.string "name"
    t.string "version"
    t.string "release"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "flags"
    t.integer "epoch"
    t.index ["package_id"], name: "index_conflicts_on_package_id"
  end

  create_table "freshmeats", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "version"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ftbfs", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "version"
    t.string "release"
    t.integer "weeks"
    t.integer "branch_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "arch"
    t.integer "maintainer_id"
    t.integer "epoch"
    t.index ["branch_id"], name: "index_ftbfs_on_branch_id"
    t.index ["maintainer_id"], name: "index_ftbfs_on_maintainer_id"
  end

  create_table "gears", id: :serial, force: :cascade do |t|
    t.string "repo"
    t.datetime "lastchange"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "maintainer_id"
    t.integer "srpm_id"
    t.index ["maintainer_id"], name: "index_gears_on_maintainer_id"
    t.index ["srpm_id"], name: "index_gears_on_srpm_id"
  end

  create_table "groups", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "branch_id"
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.index ["branch_id"], name: "index_groups_on_branch_id"
    t.index ["parent_id"], name: "index_groups_on_parent_id"
  end

  create_table "maintainer_teams", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "login", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "maintainers", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "login"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "time_zone", default: "UTC"
    t.string "jabber", default: ""
    t.text "info", default: ""
    t.string "website", default: ""
    t.string "location", default: ""
  end

  create_table "mirrors", id: :serial, force: :cascade do |t|
    t.integer "branch_id"
    t.integer "order_id"
    t.string "name"
    t.string "country"
    t.string "uri"
    t.string "protocol"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["branch_id"], name: "index_mirrors_on_branch_id"
  end

  create_table "obsoletes", id: :serial, force: :cascade do |t|
    t.integer "package_id"
    t.string "name"
    t.string "version"
    t.string "release"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "flags"
    t.integer "epoch"
    t.index ["package_id"], name: "index_obsoletes_on_package_id"
  end

  create_table "packages", id: :serial, force: :cascade do |t|
    t.string "filename"
    t.string "sourcepackage"
    t.string "name"
    t.string "version"
    t.string "release"
    t.string "arch"
    t.string "summary"
    t.string "license"
    t.string "url"
    t.text "description"
    t.datetime "buildtime"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "srpm_id"
    t.integer "group_id"
    t.string "md5"
    t.string "groupname"
    t.integer "size"
    t.integer "epoch"
    t.index ["arch"], name: "index_packages_on_arch"
    t.index ["group_id"], name: "index_packages_on_group_id"
    t.index ["name"], name: "index_packages_on_name"
    t.index ["sourcepackage"], name: "index_packages_on_sourcepackage"
    t.index ["srpm_id"], name: "index_packages_on_srpm_id"
  end

  create_table "patches", id: :serial, force: :cascade do |t|
    t.integer "srpm_id"
    t.binary "patch"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "filename"
    t.integer "size"
    t.index ["srpm_id"], name: "index_patches_on_srpm_id"
  end

  create_table "perl_watches", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "version"
    t.string "path"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_perl_watches_on_name"
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text "content"
    t.string "searchable_type"
    t.bigint "searchable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.tsvector "tsv_body"
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id"
    t.index ["tsv_body"], name: "index_pg_search_documents_on_tsv_body", using: :gin
  end

  create_table "pghero_query_stats", id: :serial, force: :cascade do |t|
    t.text "database"
    t.text "user"
    t.text "query"
    t.bigint "query_hash"
    t.float "total_time"
    t.bigint "calls"
    t.datetime "captured_at"
    t.index ["database", "captured_at"], name: "index_pghero_query_stats_on_database_and_captured_at"
  end

  create_table "platforms", force: :cascade do |t|
    t.string "name"
    t.string "version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "archived", default: false
  end

  create_table "provides", id: :serial, force: :cascade do |t|
    t.integer "package_id"
    t.string "name"
    t.string "version"
    t.string "release"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "flags"
    t.integer "epoch"
    t.index ["package_id"], name: "index_provides_on_package_id"
  end

  create_table "repocop_patches", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "version"
    t.string "release"
    t.string "url"
    t.integer "branch_id"
    t.index ["name"], name: "index_repocop_patches_on_name"
  end

  create_table "repocops", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "version"
    t.string "release"
    t.string "arch"
    t.string "srcname"
    t.string "srcversion"
    t.string "srcrel"
    t.string "testname"
    t.string "status"
    t.text "message"
    t.integer "branch_id"
    t.index ["srcname"], name: "index_repocops_on_srcname"
    t.index ["srcrel"], name: "index_repocops_on_srcrel"
    t.index ["srcversion"], name: "index_repocops_on_srcversion"
  end

  create_table "requires", id: :serial, force: :cascade do |t|
    t.integer "package_id"
    t.string "name"
    t.string "version"
    t.string "release"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "flags"
    t.integer "epoch"
    t.index ["package_id"], name: "index_requires_on_package_id"
  end

  create_table "sources", id: :serial, force: :cascade do |t|
    t.integer "srpm_id"
    t.binary "content"
    t.string "filename"
    t.integer "size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "source"
    t.index ["srpm_id"], name: "index_sources_on_srpm_id"
  end

  create_table "specfiles", id: :serial, force: :cascade do |t|
    t.integer "srpm_id"
    t.binary "spec"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["srpm_id"], name: "index_specfiles_on_srpm_id"
  end

  create_table "srpms", id: :serial, force: :cascade do |t|
    t.string "filename"
    t.string "name"
    t.string "version"
    t.string "release"
    t.string "summary"
    t.string "license"
    t.string "url"
    t.text "description"
    t.datetime "buildtime"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "repocop", default: "skip"
    t.integer "branch_id"
    t.integer "group_id"
    t.string "vendor"
    t.string "distribution"
    t.string "changelogname"
    t.text "changelogtext"
    t.string "md5"
    t.boolean "delta", default: true, null: false
    t.integer "builder_id"
    t.string "groupname"
    t.integer "size"
    t.datetime "changelogtime"
    t.integer "epoch"
    t.string "buildhost"
    t.index ["branch_id", "created_at"], name: "index_srpms_on_branch_id_and_created_at"
    t.index ["branch_id"], name: "index_srpms_on_branch_id"
    t.index ["group_id"], name: "index_srpms_on_group_id"
    t.index ["name"], name: "index_srpms_on_name"
  end

  create_table "teams", id: :serial, force: :cascade do |t|
    t.string "name"
    t.boolean "leader"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "branch_id"
    t.integer "maintainer_id"
    t.index ["branch_id"], name: "index_teams_on_branch_id"
    t.index ["maintainer_id"], name: "index_teams_on_maintainer_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "unconfirmed_email"
    t.boolean "admin", default: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "architectures", "platforms"
  add_foreign_key "srpms", "branches"
end
