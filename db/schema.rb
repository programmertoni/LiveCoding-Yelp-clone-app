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

ActiveRecord::Schema.define(version: 20151009152507) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "category_companies", force: :cascade do |t|
    t.integer "category_id"
    t.integer "company_id"
  end

  add_index "category_companies", ["category_id"], name: "index_category_companies_on_category_id", using: :btree
  add_index "category_companies", ["company_id"], name: "index_category_companies_on_company_id", using: :btree

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.integer  "price_range", limit: 2
    t.integer  "user_id"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "companies", ["user_id"], name: "index_companies_on_user_id", using: :btree

  create_table "flags", force: :cascade do |t|
    t.boolean  "flaged"
    t.integer  "review_id"
    t.integer  "flaged_user_id"
    t.integer  "flaged_by_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "flags", ["flaged_by_user_id"], name: "index_flags_on_flaged_by_user_id", using: :btree
  add_index "flags", ["flaged_user_id"], name: "index_flags_on_flaged_user_id", using: :btree
  add_index "flags", ["review_id"], name: "index_flags_on_review_id", using: :btree

  create_table "friends", force: :cascade do |t|
    t.boolean  "pending"
    t.boolean  "user_blocked"
    t.integer  "user_id"
    t.integer  "id_of_friend"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friends", ["id_of_friend"], name: "index_friends_on_id_of_friend", using: :btree
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

  create_table "reviews", force: :cascade do |t|
    t.integer  "stars",      limit: 2
    t.text     "content"
    t.integer  "user_id"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["company_id"], name: "index_reviews_on_company_id", using: :btree
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "full_name"
    t.string   "password_digest"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "votes", force: :cascade do |t|
    t.string   "vote_type"
    t.integer  "review_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["review_id"], name: "index_votes_on_review_id", using: :btree
  add_index "votes", ["user_id"], name: "index_votes_on_user_id", using: :btree

  add_foreign_key "friends", "users"
  add_foreign_key "reviews", "users"
end
