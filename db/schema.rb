# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100117024207) do

  create_table "acls", :force => true do |t|
    t.string   "package"
    t.string   "login"
    t.string   "branch"
    t.string   "vendor"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "acls", ["branch"], :name => "index_acls_on_branch"
  add_index "acls", ["login"], :name => "index_acls_on_login"
  add_index "acls", ["package"], :name => "index_acls_on_package"
  add_index "acls", ["vendor"], :name => "index_acls_on_vendor"

  create_table "branches", :force => true do |t|
    t.string   "vendor"
    t.string   "name"
    t.string   "url"
    t.string   "srpms_path"
    t.string   "binary_x86_path"
    t.string   "noarch_path"
    t.string   "binary_x86_64_path"
    t.string   "acls_url"
    t.string   "leaders_url"
    t.string   "acls_groups_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "rpm_groups_url"
    t.integer  "order_id"
  end

  create_table "bugs", :force => true do |t|
    t.integer  "bug_id"
    t.string   "bug_status"
    t.string   "resolution"
    t.string   "bug_severity"
    t.string   "product"
    t.string   "component"
    t.string   "assigned_to"
    t.string   "reporter"
    t.string   "short_desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gitrepos", :force => true do |t|
    t.string   "repo"
    t.string   "login"
    t.datetime "lastchange"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.string   "branch"
    t.string   "vendor"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leaders", :force => true do |t|
    t.string   "package"
    t.string   "login"
    t.string   "branch"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "vendor"
  end

  add_index "leaders", ["branch"], :name => "index_leaders_on_branch"
  add_index "leaders", ["package"], :name => "index_leaders_on_package"
  add_index "leaders", ["vendor"], :name => "index_leaders_on_vendor"

  create_table "packagers", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "login"
    t.boolean  "team"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "packages", :force => true do |t|
    t.string   "filename"
    t.string   "sourcepackage"
    t.string   "name"
    t.string   "version"
    t.string   "release"
    t.string   "group"
    t.string   "epoch"
    t.string   "arch"
    t.string   "summary"
    t.string   "license"
    t.string   "url"
    t.text     "description"
    t.datetime "buildtime"
    t.string   "size"
    t.string   "branch"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "vendor"
  end

  add_index "packages", ["arch"], :name => "index_packages_on_arch"
  add_index "packages", ["branch"], :name => "index_packages_on_branch"
  add_index "packages", ["sourcepackage"], :name => "index_packages_on_sourcepackage"
  add_index "packages", ["vendor"], :name => "index_packages_on_vendor"

  create_table "repocops", :force => true do |t|
    t.string   "name"
    t.string   "version"
    t.string   "release"
    t.string   "arch"
    t.string   "srcname"
    t.string   "srcversion"
    t.string   "srcrel"
    t.string   "testname"
    t.string   "status"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "repocops", ["srcname"], :name => "index_repocops_on_srcname"
  add_index "repocops", ["srcrel"], :name => "index_repocops_on_srcrel"
  add_index "repocops", ["srcversion"], :name => "index_repocops_on_srcversion"

  create_table "srpms", :force => true do |t|
    t.string   "branch"
    t.string   "vendor"
    t.string   "filename"
    t.string   "name"
    t.string   "version"
    t.string   "release"
    t.string   "epoch"
    t.string   "summary"
    t.string   "license"
    t.string   "url"
    t.text     "description"
    t.datetime "buildtime"
    t.string   "size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "group"
  end

  add_index "srpms", ["branch"], :name => "index_srpms_on_branch"
  add_index "srpms", ["name"], :name => "index_srpms_on_name"
  add_index "srpms", ["vendor"], :name => "index_srpms_on_vendor"

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.string   "login"
    t.string   "branch"
    t.boolean  "leader"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "vendor"
  end

end
