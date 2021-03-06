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

ActiveRecord::Schema.define(version: 20160512091055) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "contributor_id",                             null: false
    t.integer  "discussion_id",                              null: false
    t.string   "status",                 default: "pending"
    t.text     "body_text",                                  null: false
    t.string   "created_at_readable"
    t.integer  "accepted_review_streak", default: 0
    t.integer  "review_count",           default: 0
  end

  create_table "contributors", force: :cascade do |t|
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "password_digest",                 null: false
    t.string   "username",                        null: false
    t.string   "email"
    t.integer  "reputation",      default: 0,     null: false
    t.boolean  "blocked",         default: false, null: false
  end

  create_table "discussions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "forum_id",   null: false
    t.string   "page_url"
    t.string   "name"
  end

  create_table "flags", force: :cascade do |t|
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "comment_id",     null: false
    t.integer  "contributor_id", null: false
  end

  create_table "forums", force: :cascade do |t|
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "host_user_id",    null: false
    t.string   "root_domain",     null: false
    t.string   "forum_shortname", null: false
  end

  create_table "host_users", force: :cascade do |t|
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "host_users", ["email"], name: "index_host_users_on_email", unique: true, using: :btree
  add_index "host_users", ["reset_password_token"], name: "index_host_users_on_reset_password_token", unique: true, using: :btree

  create_table "reviews", force: :cascade do |t|
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "comment_id",     null: false
    t.integer  "contributor_id", null: false
    t.string   "result",         null: false
  end

  create_table "upvotes", force: :cascade do |t|
    t.integer  "contributor_id", null: false
    t.integer  "comment_id",     null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

end
