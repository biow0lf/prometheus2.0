# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160224213835) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "branches", force: :cascade do |t|
    t.string   "vendor"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_id"
    t.string   "path"
  end

  create_table "bugs", force: :cascade do |t|
    t.integer  "bug_id"
    t.string   "bug_status"
    t.string   "resolution"
    t.string   "bug_severity"
    t.string   "product"
    t.string   "component"
    t.string   "assigned_to"
    t.string   "reporter"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "short_desc"
  end

  add_index "bugs", ["assigned_to"], name: "index_bugs_on_assigned_to", using: :btree
  add_index "bugs", ["bug_status"], name: "index_bugs_on_bug_status", using: :btree
  add_index "bugs", ["product"], name: "index_bugs_on_product", using: :btree

  create_table "changelogs", force: :cascade do |t|
    t.integer  "srpm_id"
    t.string   "changelogtime"
    t.binary   "changelogname"
    t.binary   "changelogtext"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "delta",         default: true, null: false
  end

  add_index "changelogs", ["srpm_id"], name: "index_changelogs_on_srpm_id", using: :btree

  create_table "conflicts", force: :cascade do |t|
    t.integer  "package_id"
    t.string   "name"
    t.string   "version"
    t.string   "release"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "epoch"
    t.integer  "flags"
  end

  add_index "conflicts", ["package_id"], name: "index_conflicts_on_package_id", using: :btree

  create_table "freshmeats", force: :cascade do |t|
    t.string   "name"
    t.string   "version"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ftbfs", force: :cascade do |t|
    t.string   "name"
    t.string   "epoch"
    t.string   "version"
    t.string   "release"
    t.integer  "weeks"
    t.integer  "branch_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "arch"
    t.integer  "maintainer_id"
  end

  add_index "ftbfs", ["branch_id"], name: "index_ftbfs_on_branch_id", using: :btree
  add_index "ftbfs", ["maintainer_id"], name: "index_ftbfs_on_maintainer_id", using: :btree

  create_table "gears", force: :cascade do |t|
    t.string   "repo"
    t.datetime "lastchange"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "maintainer_id"
    t.integer  "srpm_id"
  end

  add_index "gears", ["maintainer_id"], name: "index_gears_on_maintainer_id", using: :btree
  add_index "gears", ["srpm_id"], name: "index_gears_on_srpm_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "branch_id"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
  end

  add_index "groups", ["branch_id"], name: "index_groups_on_branch_id", using: :btree
  add_index "groups", ["parent_id"], name: "index_groups_on_parent_id", using: :btree

  create_table "maintainer_teams", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "email",      null: false
    t.string   "login",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "maintainers", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "login"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "time_zone",  default: "UTC"
    t.string   "jabber",     default: ""
    t.text     "info",       default: ""
    t.string   "website",    default: ""
    t.string   "location",   default: ""
  end

  create_table "mirrors", force: :cascade do |t|
    t.integer  "branch_id"
    t.integer  "order_id"
    t.string   "name"
    t.string   "country"
    t.string   "uri"
    t.string   "protocol"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mirrors", ["branch_id"], name: "index_mirrors_on_branch_id", using: :btree

  create_table "obsoletes", force: :cascade do |t|
    t.integer  "package_id"
    t.string   "name"
    t.string   "version"
    t.string   "release"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "epoch"
    t.integer  "flags"
  end

  add_index "obsoletes", ["package_id"], name: "index_obsoletes_on_package_id", using: :btree

  create_table "packages", force: :cascade do |t|
    t.string   "filename"
    t.string   "sourcepackage"
    t.string   "name"
    t.string   "version"
    t.string   "release"
    t.string   "arch"
    t.string   "summary"
    t.string   "license"
    t.string   "url"
    t.text     "description"
    t.datetime "buildtime"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "srpm_id"
    t.integer  "group_id"
    t.string   "md5"
    t.string   "groupname"
    t.integer  "size"
    t.integer  "epoch"
  end

  add_index "packages", ["arch"], name: "index_packages_on_arch", using: :btree
  add_index "packages", ["group_id"], name: "index_packages_on_group_id", using: :btree
  add_index "packages", ["name"], name: "index_packages_on_name", using: :btree
  add_index "packages", ["sourcepackage"], name: "index_packages_on_sourcepackage", using: :btree
  add_index "packages", ["srpm_id"], name: "index_packages_on_srpm_id", using: :btree

  create_table "patches", force: :cascade do |t|
    t.integer  "srpm_id"
    t.binary   "patch"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "filename"
    t.integer  "size"
  end

  add_index "patches", ["srpm_id"], name: "index_patches_on_srpm_id", using: :btree

  create_table "perl_watches", force: :cascade do |t|
    t.string   "name"
    t.string   "version"
    t.string   "path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "perl_watches", ["name"], name: "index_perl_watches_on_name", using: :btree

  create_table "provides", force: :cascade do |t|
    t.integer  "package_id"
    t.string   "name"
    t.string   "version"
    t.string   "release"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "epoch"
    t.integer  "flags"
  end

  add_index "provides", ["package_id"], name: "index_provides_on_package_id", using: :btree

  create_table "repocop_patches", force: :cascade do |t|
    t.string  "name"
    t.string  "version"
    t.string  "release"
    t.string  "url"
    t.integer "branch_id"
  end

  add_index "repocop_patches", ["name"], name: "index_repocop_patches_on_name", using: :btree

  create_table "repocops", force: :cascade do |t|
    t.string  "name"
    t.string  "version"
    t.string  "release"
    t.string  "arch"
    t.string  "srcname"
    t.string  "srcversion"
    t.string  "srcrel"
    t.string  "testname"
    t.string  "status"
    t.text    "message"
    t.integer "branch_id"
  end

  add_index "repocops", ["srcname"], name: "index_repocops_on_srcname", using: :btree
  add_index "repocops", ["srcrel"], name: "index_repocops_on_srcrel", using: :btree
  add_index "repocops", ["srcversion"], name: "index_repocops_on_srcversion", using: :btree

  create_table "requires", force: :cascade do |t|
    t.integer  "package_id"
    t.string   "name"
    t.string   "version"
    t.string   "release"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "epoch"
    t.integer  "flags"
  end

  add_index "requires", ["package_id"], name: "index_requires_on_package_id", using: :btree

  create_table "sources", force: :cascade do |t|
    t.integer  "srpm_id"
    t.binary   "source"
    t.string   "filename"
    t.integer  "size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sources", ["srpm_id"], name: "index_sources_on_srpm_id", using: :btree

  create_table "specfiles", force: :cascade do |t|
    t.integer  "srpm_id"
    t.binary   "spec"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "specfiles", ["srpm_id"], name: "index_specfiles_on_srpm_id", using: :btree

  create_table "srpms", force: :cascade do |t|
    t.string   "filename"
    t.string   "name"
    t.string   "version"
    t.string   "release"
    t.string   "summary"
    t.string   "license"
    t.string   "url"
    t.text     "description"
    t.datetime "buildtime"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "repocop",       default: "skip"
    t.integer  "branch_id"
    t.integer  "group_id"
    t.string   "vendor"
    t.string   "distribution"
    t.string   "changelogname"
    t.text     "changelogtext"
    t.string   "md5"
    t.boolean  "delta",         default: true,   null: false
    t.integer  "builder_id"
    t.string   "groupname"
    t.integer  "size"
    t.datetime "changelogtime"
    t.integer  "epoch"
  end

  add_index "srpms", ["branch_id"], name: "index_srpms_on_branch_id", using: :btree
  add_index "srpms", ["group_id"], name: "index_srpms_on_group_id", using: :btree
  add_index "srpms", ["name"], name: "index_srpms_on_name", using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.boolean  "leader"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "branch_id"
    t.integer  "maintainer_id"
  end

  add_index "teams", ["branch_id"], name: "index_teams_on_branch_id", using: :btree
  add_index "teams", ["maintainer_id"], name: "index_teams_on_maintainer_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "unconfirmed_email"
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
