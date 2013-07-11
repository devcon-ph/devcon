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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130627073551) do

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "author_id"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "slug"
    t.text     "summary"
    t.string   "thumbnail"
    t.boolean  "published",    :default => false
    t.datetime "published_at"
  end

  add_index "articles", ["author_id", "created_at"], :name => "index_articles_on_author_id_and_created_at"
  add_index "articles", ["published"], :name => "index_articles_on_published"
  add_index "articles", ["slug"], :name => "index_articles_on_slug", :unique => true

  create_table "articles_categories", :id => false, :force => true do |t|
    t.integer "article_id"
    t.integer "category_id"
  end

  create_table "articles_tags", :id => false, :force => true do |t|
    t.integer "article_id"
    t.integer "tag_id"
  end

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "authentications", ["user_id"], :name => "index_authentications_on_user_id"

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "slug"
  end

  add_index "categories", ["slug"], :name => "index_categories_on_slug", :unique => true

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "entities", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.text     "description"
    t.text     "blurb"
    t.string   "logo"
    t.string   "type"
    t.string   "level"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "formal_name"
    t.string   "short_name"
    t.boolean  "display",     :default => false
  end

  add_index "entities", ["display"], :name => "index_entities_on_display"
  add_index "entities", ["level"], :name => "index_entities_on_level"
  add_index "entities", ["slug"], :name => "index_entities_on_slug", :unique => true
  add_index "entities", ["type"], :name => "index_entities_on_type"

  create_table "event_partners", :force => true do |t|
    t.integer  "event_id"
    t.integer  "entity_id"
    t.string   "role"
    t.text     "custom_blurb"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "event_partners", ["entity_id"], :name => "index_event_partners_on_entity_id"
  add_index "event_partners", ["event_id"], :name => "index_event_partners_on_event_id"

  create_table "events", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.text     "description"
    t.integer  "venue_id"
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer  "parent_id"
    t.string   "logo"
    t.string   "devcon_role"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.text     "summary"
    t.text     "schedule"
    t.text     "rules"
    t.text     "registration"
    t.boolean  "published",        :default => false
    t.string   "event_type"
    t.integer  "target_attendees"
    t.integer  "actual_attendees"
    t.string   "cover_photo"
  end

  add_index "events", ["parent_id"], :name => "index_events_on_parent_id"
  add_index "events", ["published"], :name => "index_events_on_published"
  add_index "events", ["slug"], :name => "index_events_on_slug", :unique => true
  add_index "events", ["venue_id"], :name => "index_events_on_venue_id"

  create_table "participants", :force => true do |t|
    t.integer  "event_id"
    t.integer  "resource_person_id"
    t.string   "role"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.text     "custom_description"
    t.string   "custom_title"
  end

  add_index "participants", ["event_id"], :name => "index_participants_on_event_id"
  add_index "participants", ["resource_person_id"], :name => "index_participants_on_resource_person_id"

  create_table "presentations", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.integer  "event_id"
    t.integer  "speaker_id"
    t.string   "slide_link"
    t.string   "video_link"
    t.text     "description"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.boolean  "display",     :default => false
  end

  add_index "presentations", ["display"], :name => "index_presentations_on_display"
  add_index "presentations", ["event_id"], :name => "index_presentations_on_event_id"
  add_index "presentations", ["slug"], :name => "index_presentations_on_slug", :unique => true
  add_index "presentations", ["speaker_id"], :name => "index_presentations_on_speaker_id"

  create_table "resource_people", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.text     "description"
    t.string   "main_title"
    t.string   "thumbnail"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.boolean  "display",     :default => false
  end

  add_index "resource_people", ["display"], :name => "index_resource_people_on_display"
  add_index "resource_people", ["slug"], :name => "index_resource_people_on_slug"

  create_table "speakers", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "speakers", ["slug"], :name => "index_speakers_on_slug", :unique => true

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "name"
    t.integer  "roles_mask"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "venues", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.text     "address"
    t.decimal  "latitude",    :precision => 15, :scale => 12
    t.decimal  "longitude",   :precision => 15, :scale => 12
    t.text     "description"
    t.datetime "created_at",                                                     :null => false
    t.datetime "updated_at",                                                     :null => false
    t.text     "directions"
    t.boolean  "display",                                     :default => false
  end

  add_index "venues", ["display"], :name => "index_venues_on_display"
  add_index "venues", ["slug"], :name => "index_venues_on_slug", :unique => true

end
