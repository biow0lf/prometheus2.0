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

  create_table "maintainer_teams", force: true do |t|
    t.string   "name",       null: false
    t.string   "email",      null: false
    t.string   "login",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
