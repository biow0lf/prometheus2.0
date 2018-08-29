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

ActiveRecord::Schema.define(version: 2018_08_23_105800) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "btree_gin"
  enable_extension "pg_stat_statements"
  enable_extension "plpgsql"

  create_table "branch_paths", force: :cascade do |t|
    t.string "arch", comment: "Архитектура, используемая для ветви"
    t.string "path", comment: "Путь ко хранилищу rpm-пакетов для архитектуры"
    t.bigint "branch_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "source_path_id", comment: "Указатель на путь к ветви родительских пакетов"
    t.boolean "active", default: true, comment: "Флаг задействования пути ветви, если установлен, то путь активен"
    t.string "name", comment: "Имя пути ветви"
    t.integer "srpms_count", default: 0, comment: "Счётчик именованных исходных пакетов для пути ветви"
    t.datetime "imported_at", default: "1970-01-01 00:00:00", null: false, comment: "Время последнего импорта пакетов для пути ветви"
    t.index ["arch", "branch_id", "source_path_id"], name: "index_branch_paths_on_arch_and_branch_id_and_source_path_id", unique: true
    t.index ["arch", "path"], name: "index_branch_paths_on_arch_and_path", unique: true
    t.index ["arch"], name: "index_branch_paths_on_arch", using: :gin
    t.index ["branch_id"], name: "index_branch_paths_on_branch_id"
    t.index ["name"], name: "index_branch_paths_on_name"
    t.index ["path"], name: "index_branch_paths_on_path", using: :gin
    t.index ["source_path_id"], name: "index_branch_paths_on_source_path_id"
  end

  create_table "branches", id: :serial, force: :cascade do |t|
    t.string "vendor", limit: 255
    t.string "name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "order_id"
    t.string "path", limit: 255
    t.integer "srpms_count", default: 0, comment: "Счётчик уникальных исходных пакетов для ветви"
    t.string "slug", null: false, comment: "Плашка для обращения к ветви в строке пути браузера"
    t.index ["name"], name: "index_branches_on_name"
    t.index ["slug"], name: "index_branches_on_slug", unique: true
  end

  create_table "branching_maintainers", force: :cascade do |t|
    t.bigint "branch_id"
    t.bigint "maintainer_id"
    t.integer "srpms_count", default: 0, null: false, comment: "Счётчик уникальных исходных пакетов, собранных поставщиком для ветви"
    t.index ["branch_id"], name: "index_branching_maintainers_on_branch_id"
    t.index ["maintainer_id"], name: "index_branching_maintainers_on_maintainer_id"
  end

  create_table "bugs", id: :serial, force: :cascade do |t|
    t.integer "bug_id"
    t.string "bug_status", limit: 255
    t.string "resolution", limit: 255
    t.string "bug_severity", limit: 255
    t.string "product", limit: 255
    t.string "component", limit: 255
    t.string "assigned_to", limit: 255
    t.string "reporter", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "short_desc"
    t.index ["assigned_to"], name: "index_bugs_on_assigned_to"
    t.index ["bug_status"], name: "index_bugs_on_bug_status"
    t.index ["component"], name: "index_bugs_on_component"
    t.index ["product"], name: "index_bugs_on_product"
  end

  create_table "changelogs", id: :serial, force: :cascade do |t|
    t.string "changelogtime", limit: 255
    t.binary "changelogname"
    t.binary "changelogtext"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "delta", default: true, null: false
    t.bigint "package_id", comment: "Ссылка на пакет"
    t.index ["package_id"], name: "index_changelogs_on_package_id"
  end

  create_table "conflicts", id: :serial, force: :cascade do |t|
    t.integer "package_id"
    t.string "name", limit: 255
    t.string "version", limit: 255
    t.string "release", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "flags"
    t.integer "epoch"
    t.index ["package_id"], name: "index_conflicts_on_package_id"
  end

  create_table "freshmeats", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "version", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ftbfs", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "version", limit: 255
    t.string "release", limit: 255
    t.integer "weeks"
    t.integer "branch_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "arch", limit: 255
    t.integer "maintainer_id"
    t.integer "epoch"
    t.index ["branch_id"], name: "index_ftbfs_on_branch_id"
    t.index ["maintainer_id"], name: "index_ftbfs_on_maintainer_id"
  end

  create_table "gears", id: :serial, force: :cascade do |t|
    t.string "repo", limit: 255
    t.datetime "lastchange"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "maintainer_id"
    t.bigint "package_id", comment: "Ссылка на пакет"
    t.index ["maintainer_id"], name: "index_gitrepos_on_maintainer_id"
    t.index ["package_id"], name: "index_gears_on_package_id"
  end

  create_table "groups", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
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
    t.string "name", limit: 255, null: false
    t.string "email", limit: 255, null: false
    t.string "login", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "maintainers", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "email", limit: 255
    t.string "login", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "time_zone", limit: 255, default: "UTC"
    t.string "jabber", limit: 255, default: ""
    t.text "info", default: ""
    t.string "website", limit: 255, default: ""
    t.string "location", limit: 255, default: ""
    t.integer "srpms_count", default: 0, comment: "Счётчик уникальных исходных пакетов, собранных поставщиком"
  end

  create_table "mirrors", id: :serial, force: :cascade do |t|
    t.integer "branch_id"
    t.integer "order_id"
    t.string "name", limit: 255
    t.string "country", limit: 255
    t.string "uri", limit: 255
    t.string "protocol", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["branch_id"], name: "index_mirrors_on_branch_id"
  end

  create_table "obsoletes", id: :serial, force: :cascade do |t|
    t.integer "package_id"
    t.string "name", limit: 255
    t.string "version", limit: 255
    t.string "release", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "flags"
    t.integer "epoch"
    t.index ["package_id"], name: "index_obsoletes_on_package_id"
  end

  create_table "packages", id: :serial, force: :cascade do |t|
    t.string "filename", limit: 255
    t.string "sourcepackage", limit: 255
    t.string "name", limit: 255
    t.string "version", limit: 255
    t.string "release", limit: 255
    t.string "arch", limit: 255
    t.string "summary", limit: 255
    t.string "license", limit: 255
    t.string "url", limit: 255
    t.text "description"
    t.datetime "buildtime"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "srpm_id"
    t.integer "group_id"
    t.string "md5", limit: 255, null: false
    t.string "groupname", limit: 255
    t.integer "size"
    t.integer "epoch"
    t.tsvector "tsv"
    t.string "repocop", default: "skip", comment: "Статус проверки репокопом"
    t.string "vendor", comment: "Распространитель пакета"
    t.string "distribution", comment: "Срез набора пакетов"
    t.string "buildhost", comment: "Место сборки пакета"
    t.string "type", comment: "Вид пакета: исходник или двояк"
    t.bigint "builder_id", comment: "Собиратель пакета"
    t.integer "src_id", comment: "Ссылка на исходный пакет, может указывать на самого себя"
    t.integer "_src_id"
    t.index ["arch"], name: "index_packages_on_arch"
    t.index ["builder_id"], name: "index_packages_on_builder_id"
    t.index ["group_id"], name: "index_packages_on_group_id"
    t.index ["md5"], name: "index_packages_on_md5", unique: true
    t.index ["name"], name: "index_packages_on_name"
    t.index ["sourcepackage"], name: "index_packages_on_sourcepackage"
    t.index ["srpm_id"], name: "index_packages_on_srpm_id"
    t.index ["tsv"], name: "index_packages_on_tsv", using: :gin
  end

  create_table "patches", id: :serial, force: :cascade do |t|
    t.binary "patch"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "filename", limit: 255
    t.integer "size"
    t.bigint "package_id", comment: "Ссылка на пакет"
    t.index ["package_id"], name: "index_patches_on_package_id"
  end

  create_table "perl_watches", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "version", limit: 255
    t.string "path", limit: 255
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

  create_table "provides", id: :serial, force: :cascade do |t|
    t.integer "package_id"
    t.string "name", limit: 255
    t.string "version", limit: 255
    t.string "release", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "flags"
    t.integer "epoch"
    t.index ["package_id"], name: "index_provides_on_package_id"
  end

  create_table "repocop_patches", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "version", limit: 255
    t.string "release", limit: 255
    t.string "url", limit: 255
    t.integer "branch_id"
    t.index ["name"], name: "index_repocop_patches_on_name"
  end

  create_table "repocops", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "version", limit: 255
    t.string "release", limit: 255
    t.string "arch", limit: 255
    t.string "srcname", limit: 255
    t.string "srcversion", limit: 255
    t.string "srcrel", limit: 255
    t.string "testname", limit: 255
    t.string "status", limit: 255
    t.text "message"
    t.integer "branch_id"
    t.index ["srcname"], name: "index_repocops_on_srcname"
    t.index ["srcrel"], name: "index_repocops_on_srcrel"
    t.index ["srcversion"], name: "index_repocops_on_srcversion"
  end

  create_table "requires", id: :serial, force: :cascade do |t|
    t.integer "package_id"
    t.string "name", limit: 255
    t.string "version", limit: 255
    t.string "release", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "flags"
    t.integer "epoch"
    t.index ["package_id"], name: "index_requires_on_package_id"
  end

  create_table "rpms", force: :cascade do |t|
    t.string "filename", null: false, comment: "Имя файла srpm, такое, как он представлен в заданной ветви"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "branch_path_id", comment: "Указатель на путь к ветви, откуда пакет был истянут"
    t.string "name", null: false, comment: "Имя исходного пакета"
    t.datetime "obsoleted_at", comment: "Время устаревания пакета, если установлено, то пакет более не находится в ветви"
    t.bigint "package_id", comment: "Ссылка на пакет"
    t.index ["branch_path_id", "filename"], name: "index_rpms_on_branch_path_id_and_filename", unique: true
    t.index ["branch_path_id", "package_id"], name: "index_rpms_on_branch_path_id_and_package_id", unique: true
    t.index ["branch_path_id"], name: "index_rpms_on_branch_path_id"
    t.index ["filename"], name: "index_rpms_on_filename"
    t.index ["name"], name: "index_rpms_on_name"
    t.index ["package_id"], name: "index_rpms_on_package_id"
  end

  create_table "sources", id: :serial, force: :cascade do |t|
    t.binary "content"
    t.string "filename", limit: 255
    t.integer "size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "source"
    t.bigint "package_id", comment: "Ссылка на пакет"
    t.index ["package_id"], name: "index_sources_on_package_id"
  end

  create_table "specfiles", id: :serial, force: :cascade do |t|
    t.binary "spec"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "package_id", comment: "Ссылка на пакет"
    t.index ["package_id"], name: "index_specfiles_on_package_id"
  end

  create_table "srpms", id: :serial, force: :cascade do |t|
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

  create_table "teams", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.boolean "leader"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "branch_id"
    t.integer "maintainer_id"
    t.index ["branch_id"], name: "index_teams_on_branch_id"
    t.index ["maintainer_id"], name: "index_teams_on_maintainer_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", limit: 255, default: "", null: false
    t.string "encrypted_password", limit: 128, default: "", null: false
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip", limit: 255
    t.string "last_sign_in_ip", limit: 255
    t.string "confirmation_token", limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "unconfirmed_email", limit: 255
    t.boolean "admin", default: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "branch_paths", "branch_paths", column: "source_path_id", on_delete: :cascade
  add_foreign_key "branch_paths", "branches", on_delete: :cascade
  add_foreign_key "changelogs", "packages", on_delete: :restrict
  add_foreign_key "ftbfs", "branches", on_delete: :cascade
  add_foreign_key "gears", "packages", on_delete: :restrict
  add_foreign_key "groups", "branches", on_delete: :cascade
  add_foreign_key "mirrors", "branches", on_delete: :cascade
  add_foreign_key "packages", "maintainers", column: "builder_id", on_delete: :restrict
  add_foreign_key "patches", "packages", on_delete: :restrict
  add_foreign_key "repocop_patches", "branches", on_delete: :cascade
  add_foreign_key "repocops", "branches", on_delete: :cascade
  add_foreign_key "rpms", "branch_paths", on_delete: :cascade
  add_foreign_key "rpms", "packages", on_delete: :cascade
  add_foreign_key "sources", "packages", on_delete: :restrict
  add_foreign_key "specfiles", "packages", on_delete: :restrict
  add_foreign_key "teams", "branches", on_delete: :cascade
end
