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

ActiveRecord::Schema.define(version: 20150923124148) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string   "title",           limit: 255
    t.text     "content"
    t.integer  "author_id"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "slug",            limit: 255
    t.text     "summary"
    t.string   "thumbnail",       limit: 255
    t.boolean  "published",                   default: false
    t.datetime "published_at"
    t.boolean  "draft",                       default: false
    t.string   "opengraph_image"
  end

  add_index "articles", ["author_id", "created_at"], name: "index_articles_on_author_id_and_created_at", using: :btree
  add_index "articles", ["draft"], name: "index_articles_on_draft", using: :btree
  add_index "articles", ["published"], name: "index_articles_on_published", using: :btree
  add_index "articles", ["slug"], name: "index_articles_on_slug", unique: true, using: :btree

  create_table "articles_categories", id: false, force: :cascade do |t|
    t.integer "article_id"
    t.integer "category_id"
  end

  create_table "articles_tags", id: false, force: :cascade do |t|
    t.integer "article_id"
    t.integer "tag_id"
  end

  create_table "authentications", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider",   limit: 255
    t.string   "uid",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "authentications", ["user_id"], name: "index_authentications_on_user_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "slug",        limit: 255
  end

  add_index "categories", ["slug"], name: "index_categories_on_slug", unique: true, using: :btree

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",    limit: 255, null: false
    t.string   "data_content_type", limit: 255
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "entities", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "slug",        limit: 255
    t.text     "description"
    t.text     "blurb"
    t.string   "logo",        limit: 255
    t.string   "type",        limit: 255
    t.string   "level",       limit: 255
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "formal_name", limit: 255
    t.string   "short_name",  limit: 255
    t.boolean  "display",                 default: false
  end

  add_index "entities", ["display"], name: "index_entities_on_display", using: :btree
  add_index "entities", ["level"], name: "index_entities_on_level", using: :btree
  add_index "entities", ["slug"], name: "index_entities_on_slug", unique: true, using: :btree
  add_index "entities", ["type"], name: "index_entities_on_type", using: :btree

  create_table "event_partners", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "entity_id"
    t.string   "role",         limit: 255
    t.text     "custom_blurb"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "event_partners", ["entity_id"], name: "index_event_partners_on_entity_id", using: :btree
  add_index "event_partners", ["event_id"], name: "index_event_partners_on_event_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.string   "slug",             limit: 255
    t.text     "description"
    t.integer  "venue_id"
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer  "parent_id"
    t.string   "logo",             limit: 255
    t.string   "devcon_role",      limit: 255
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.text     "summary"
    t.text     "schedule"
    t.text     "rules"
    t.text     "registration"
    t.boolean  "published",                    default: false
    t.string   "event_type",       limit: 255
    t.integer  "target_attendees"
    t.integer  "actual_attendees"
    t.string   "cover_photo",      limit: 255
  end

  add_index "events", ["parent_id"], name: "index_events_on_parent_id", using: :btree
  add_index "events", ["published"], name: "index_events_on_published", using: :btree
  add_index "events", ["slug"], name: "index_events_on_slug", unique: true, using: :btree
  add_index "events", ["venue_id"], name: "index_events_on_venue_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "name",                   limit: 255
    t.integer  "roles_mask"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "venues", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "slug",        limit: 255
    t.text     "address"
    t.decimal  "latitude",                precision: 15, scale: 12
    t.decimal  "longitude",               precision: 15, scale: 12
    t.text     "description"
    t.datetime "created_at",                                                        null: false
    t.datetime "updated_at",                                                        null: false
    t.text     "directions"
    t.boolean  "display",                                           default: false
  end

  add_index "venues", ["display"], name: "index_venues_on_display", using: :btree
  add_index "venues", ["slug"], name: "index_venues_on_slug", using: :btree

end
