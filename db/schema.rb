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

ActiveRecord::Schema.define(version: 20160420114136) do

  create_table "donations", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.integer  "amount",          limit: 4
    t.integer  "donate_way",      limit: 4
    t.datetime "donate_date"
    t.string   "receipt_title",   limit: 255
    t.string   "receipt_address", limit: 255
    t.string   "phone",           limit: 255
    t.string   "email",           limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "links", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "web_addr",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "pictures", force: :cascade do |t|
    t.integer  "story_id",           limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
  end

  create_table "projects", force: :cascade do |t|
    t.datetime "year"
    t.string   "name",          limit: 255
    t.integer  "kind",          limit: 4
    t.integer  "budget",        limit: 4
    t.integer  "income",        limit: 4
    t.integer  "exp_personnel", limit: 4
    t.integer  "exp_business",  limit: 4
    t.integer  "exp_mix",       limit: 4
    t.integer  "exp_other",     limit: 4
    t.string   "exe_desc",      limit: 255
    t.boolean  "donate_flag"
    t.string   "abbreviation",  limit: 255
    t.datetime "account_begin"
    t.datetime "account_end"
    t.string   "p_account",     limit: 255
    t.string   "p_password",    limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "stories", force: :cascade do |t|
    t.text     "description", limit: 65535
    t.string   "topic",       limit: 255
    t.string   "video_url",   limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
