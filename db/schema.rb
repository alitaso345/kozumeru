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

ActiveRecord::Schema.define(version: 20150411122633) do

  create_table "maids", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "floor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "number",     null: false
  end

  add_index "maids", ["name", "number"], name: "index_maids_on_name_and_number", unique: true

  create_table "pictures", force: :cascade do |t|
    t.integer  "tweet_id",   null: false
    t.string   "url",        null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "pictures", ["tweet_id"], name: "index_pictures_on_tweet_id"
  add_index "pictures", ["url"], name: "index_pictures_on_url", unique: true

  create_table "tweets", force: :cascade do |t|
    t.integer  "twitter_account_id", null: false
    t.text     "text",               null: false
    t.string   "status_id",          null: false
    t.datetime "published_at",       null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "tweets", ["status_id"], name: "index_tweets_on_status_id", unique: true
  add_index "tweets", ["twitter_account_id"], name: "index_tweets_on_twitter_account_id"

  create_table "twitter_accounts", force: :cascade do |t|
    t.string   "uid",         null: false
    t.string   "screen_name", null: false
    t.integer  "maid_id",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "twitter_accounts", ["maid_id"], name: "index_twitter_accounts_on_maid_id"
  add_index "twitter_accounts", ["uid", "screen_name"], name: "index_twitter_accounts_on_uid_and_screen_name", unique: true

end
