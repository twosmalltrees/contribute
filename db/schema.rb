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

ActiveRecord::Schema.define(version: 20160428124926) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "contributor_id",                     null: false
    t.integer  "forum_id",                           null: false
    t.boolean  "pending",        default: true
    t.boolean  "removed",        default: false
    t.string   "status",         default: "pending"
    t.boolean  "is_reply",       default: false
    t.integer  "reply_to"
    t.text     "body_text",                          null: false
  end

  create_table "contributors", force: :cascade do |t|
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
  end

  create_table "flags", force: :cascade do |t|
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "comment_id",     null: false
    t.integer  "contributor_id", null: false
  end

  create_table "forums", force: :cascade do |t|
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "host_user_id", null: false
  end

  create_table "host_users", force: :cascade do |t|
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
  end

  create_table "reviews", force: :cascade do |t|
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "comment_id",     null: false
    t.integer  "contributor_id", null: false
  end

  create_table "upvotes", force: :cascade do |t|
    t.integer  "contributor_id", null: false
    t.integer  "comment_id",     null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

end
