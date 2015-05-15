 * Detect language and redirect user to localized pages
 * Add ability to disable language detection
 * Fix rubocop warnings: rubocop --only Style/CommentIndentation
 * Fix rubocop warnings: rubocop --only Style/DotPosition
 * Default ftp mirror for altlinux.org don't work.
 * Drop group class.
 * HTTPS
 * Update sitemap
 * Fix string epoch


Добавить в srpm поле repocop_status_prev в котором хранить предыдущий статус
репокопа до обновления srpm.



  create_table "freshmeats", force: true do |t|
    t.string   "name"
    t.string   "version"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gears", force: true do |t|
    t.string   "repo"
    t.datetime "lastchange"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "maintainer_id"
    t.integer  "srpm_id"
  end

  add_index "gears", ["maintainer_id"], name: "index_gears_on_maintainer_id", using: :btree
  add_index "gears", ["srpm_id"], name: "index_gears_on_srpm_id", using: :btree

  create_table "groups", force: true do |t|
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

  create_table "maintainer_teams", force: true do |t|
    t.string   "name",       null: false
    t.string   "email",      null: false
    t.string   "login",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "maintainers", force: true do |t|
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

  create_table "mirrors", force: true do |t|
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

  create_table "patches", force: true do |t|
    t.integer  "srpm_id"
    t.binary   "patch"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "filename"
    t.integer  "size"
  end

  add_index "patches", ["srpm_id"], name: "index_patches_on_srpm_id", using: :btree

  create_table "sources", force: true do |t|
    t.integer  "srpm_id"
    t.binary   "source"
    t.string   "filename"
    t.integer  "size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sources", ["srpm_id"], name: "index_sources_on_srpm_id", using: :btree

  create_table "specfiles", force: true do |t|
    t.integer  "srpm_id"
    t.binary   "spec"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "specfiles", ["srpm_id"], name: "index_specfiles_on_srpm_id", using: :btree

  create_table "teams", force: true do |t|
    t.string   "name"
    t.boolean  "leader"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "branch_id"
    t.integer  "maintainer_id"
  end

  add_index "teams", ["branch_id"], name: "index_teams_on_branch_id", using: :btree
  add_index "teams", ["maintainer_id"], name: "index_teams_on_maintainer_id", using: :btree

end
