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

ActiveRecord::Schema.define(version: 20160118224742) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contests", force: :cascade do |t|
    t.integer  "season",           null: false
    t.integer  "level",            null: false
    t.integer  "host_id"
    t.date     "begins",           null: false
    t.date     "ends",             null: false
    t.date     "certificate_date"
    t.datetime "signup_deadline",  null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "contests", ["host_id"], name: "index_contests_on_host_id", using: :btree

  create_table "hosts", force: :cascade do |t|
    t.string   "name",         null: false
    t.string   "city",         null: false
    t.string   "country_code", null: false
    t.string   "time_zone",    null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "hosts_users", id: false, force: :cascade do |t|
    t.integer "host_id", null: false
    t.integer "user_id", null: false
  end

  add_index "hosts_users", ["host_id", "user_id"], name: "index_hosts_users_on_host_id_and_user_id", unique: true, using: :btree
  add_index "hosts_users", ["user_id"], name: "index_hosts_users_on_user_id", using: :btree

  create_table "performances", force: :cascade do |t|
    t.integer  "contest_id"
    t.integer  "predecessor_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "performances", ["contest_id"], name: "index_performances_on_contest_id", using: :btree
  add_index "performances", ["predecessor_id"], name: "index_performances_on_predecessor_id", using: :btree

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "contests", "hosts"
  add_foreign_key "performances", "contests"
end
