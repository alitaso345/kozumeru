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

ActiveRecord::Schema.define(version: 20150425012959) do

  create_table "blogs", force: :cascade do |t|
    t.integer  "maid_id",      limit: 4,   null: false
    t.string   "title",        limit: 255, null: false
    t.string   "account_name", limit: 255, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "blogs", ["account_name"], name: "index_blogs_on_account_name", unique: true, using: :btree
  add_index "blogs", ["maid_id"], name: "index_blogs_on_maid_id", using: :btree

  create_table "maids", force: :cascade do |t|
    t.string   "name",       limit: 255,                 null: false
    t.string   "floor",      limit: 255
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "number",     limit: 4,                   null: false
    t.boolean  "graduated",  limit: 1,   default: false, null: false
  end

  add_index "maids", ["number"], name: "index_maids_on_number", unique: true, using: :btree

  create_table "pictures", force: :cascade do |t|
    t.integer  "tweet_id",     limit: 4,                   null: false
    t.string   "url",          limit: 255,                 null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.boolean  "analyzed",     limit: 1,   default: false, null: false
    t.integer  "kind",         limit: 4
    t.datetime "published_at",                             null: false
  end

  add_index "pictures", ["tweet_id"], name: "index_pictures_on_tweet_id", using: :btree
  add_index "pictures", ["url"], name: "index_pictures_on_url", unique: true, using: :btree

  create_table "posts", force: :cascade do |t|
    t.integer  "blog_id",      limit: 4,     null: false
    t.string   "url",          limit: 255,   null: false
    t.string   "title",        limit: 255,   null: false
    t.text     "body",         limit: 65535, null: false
    t.datetime "published_at",               null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "posts", ["blog_id"], name: "index_posts_on_blog_id", using: :btree
  add_index "posts", ["url"], name: "index_posts_on_url", unique: true, using: :btree

  create_table "serving_days", force: :cascade do |t|
    t.integer  "maid_id",    limit: 4,             null: false
    t.integer  "picture_id", limit: 4,             null: false
    t.date     "date",                             null: false
    t.time     "start_time"
    t.time     "end_time"
    t.integer  "location",   limit: 4, default: 0, null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "serving_days", ["maid_id"], name: "index_serving_days_on_maid_id", using: :btree
  add_index "serving_days", ["picture_id"], name: "index_serving_days_on_picture_id", using: :btree

  create_table "tweets", force: :cascade do |t|
    t.integer  "twitter_account_id", limit: 4,     null: false
    t.text     "text",               limit: 65535, null: false
    t.string   "status_id",          limit: 255,   null: false
    t.datetime "published_at",                     null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "tweets", ["status_id"], name: "index_tweets_on_status_id", unique: true, using: :btree
  add_index "tweets", ["twitter_account_id"], name: "index_tweets_on_twitter_account_id", using: :btree

  create_table "twitter_accounts", force: :cascade do |t|
    t.string   "uid",         limit: 255, null: false
    t.string   "screen_name", limit: 255, null: false
    t.integer  "maid_id",     limit: 4,   null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "twitter_accounts", ["maid_id"], name: "index_twitter_accounts_on_maid_id", using: :btree
  add_index "twitter_accounts", ["uid", "screen_name"], name: "index_twitter_accounts_on_uid_and_screen_name", unique: true, using: :btree

end
