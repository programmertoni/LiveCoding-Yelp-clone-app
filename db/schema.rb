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

ActiveRecord::Schema.define(version: 20150930144000) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friends", force: :cascade do |t|
    t.boolean  "pending"
    t.boolean  "user_blocked"
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friends", ["friend_id"], name: "index_friends_on_friend_id", using: :btree
  add_index "friends", ["user_id"], name: "index_friends_on_user_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.string   "title"
    t.string   "content"
    t.boolean  "message_read", default: false
    t.boolean  "important",    default: false
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["user_id", "friend_id"], name: "index_messages_on_user_id_and_friend_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "full_name"
    t.string   "password_digest"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "friends", "users"
end
