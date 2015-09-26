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

2015-09-24 15:05:06 +0400: Update Sisyphus stuff
2015-09-24 15:05:06 +0400: update *.src.rpm from Sisyphus to database
2015-09-24 15:05:09 +0400: import 'v8-chromium-4.5.103.34-alt1.src.rpm'
2015-09-24 15:05:43 +0400: import 'chromium-45.0.2454.99-alt1.src.rpm'
2015-09-24 15:47:30 +0400: end
2015-09-24 15:47:30 +0400: update *.i586.rpm/*.noarch.rpm/*.x86_64.rpm from Sisyphus to database
2015-09-24 15:47:31 +0400: import 'chromium-45.0.2454.99-alt1.i586.rpm'
2015-09-24 15:47:35 +0400: import 'librfxcodec-0.1.0-alt1.git20150921.i586.rpm'
2015-09-24 15:47:35 +0400: srpm 'librfxcodec-0.1.0-alt1.git20150921.src.rpm' not found in db
2015-09-24 15:47:35 +0400: import 'libv8-chromium-devel-4.5.103.34-alt1.i586.rpm'
2015-09-24 15:47:37 +0400: import 'chromium-kde-45.0.2454.99-alt1.i586.rpm'
2015-09-24 15:47:40 +0400: import 'chromium-gnome-45.0.2454.99-alt1.i586.rpm'
2015-09-24 15:47:41 +0400: import 'librfxcodec-debuginfo-0.1.0-alt1.git20150921.i586.rpm'
2015-09-24 15:47:42 +0400: srpm 'librfxcodec-0.1.0-alt1.git20150921.src.rpm' not found in db
2015-09-24 15:47:42 +0400: import 'libv8-chromium-debuginfo-4.5.103.34-alt1.i586.rpm'
2015-09-24 15:47:43 +0400: import 'libv8-chromium-devel-debuginfo-4.5.103.34-alt1.i586.rpm'
2015-09-24 15:47:45 +0400: import 'libv8-chromium-4.5.103.34-alt1.i586.rpm'
2015-09-24 15:47:47 +0400: import 'librfxcodec-devel-0.1.0-alt1.git20150921.i586.rpm'
2015-09-24 15:47:47 +0400: srpm 'librfxcodec-0.1.0-alt1.git20150921.src.rpm' not found in db
2015-09-24 15:47:52 +0400: import 'libv8-chromium-debuginfo-4.5.103.34-alt1.x86_64.rpm'
2015-09-24 15:47:55 +0400: import 'chromium-45.0.2454.99-alt1.x86_64.rpm'
2015-09-24 15:47:57 +0400: import 'libv8-chromium-devel-4.5.103.34-alt1.x86_64.rpm'
2015-09-24 15:47:59 +0400: import 'chromium-kde-45.0.2454.99-alt1.x86_64.rpm'
2015-09-24 15:48:01 +0400: import 'librfxcodec-debuginfo-0.1.0-alt1.git20150921.x86_64.rpm'
2015-09-24 15:48:01 +0400: srpm 'librfxcodec-0.1.0-alt1.git20150921.src.rpm' not found in db
2015-09-24 15:48:02 +0400: import 'librfxcodec-0.1.0-alt1.git20150921.x86_64.rpm'
2015-09-24 15:48:02 +0400: srpm 'librfxcodec-0.1.0-alt1.git20150921.src.rpm' not found in db
2015-09-24 15:48:02 +0400: import 'librfxcodec-devel-0.1.0-alt1.git20150921.x86_64.rpm'
2015-09-24 15:48:02 +0400: srpm 'librfxcodec-0.1.0-alt1.git20150921.src.rpm' not found in db
2015-09-24 15:48:04 +0400: import 'libv8-chromium-devel-debuginfo-4.5.103.34-alt1.x86_64.rpm'
2015-09-24 15:48:05 +0400: import 'chromium-gnome-45.0.2454.99-alt1.x86_64.rpm'
2015-09-24 15:48:07 +0400: import 'libv8-chromium-4.5.103.34-alt1.x86_64.rpm'
2015-09-24 15:48:09 +0400: end
