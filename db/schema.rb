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

ActiveRecord::Schema.define(version: 20160709123624) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appearances", force: :cascade do |t|
    t.integer  "performance_id",   null: false
    t.integer  "participant_id",   null: false
    t.integer  "instrument_id",    null: false
    t.string   "participant_role", null: false
    t.integer  "points"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "appearances", ["instrument_id"], name: "index_appearances_on_instrument_id", using: :btree
  add_index "appearances", ["participant_id"], name: "index_appearances_on_participant_id", using: :btree
  add_index "appearances", ["performance_id"], name: "index_appearances_on_performance_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "slug",       null: false
    t.string   "genre",      null: false
    t.boolean  "solo",       null: false
    t.boolean  "ensemble",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contest_categories", force: :cascade do |t|
    t.integer  "contest_id",  null: false
    t.integer  "category_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "contest_categories", ["category_id"], name: "index_contest_categories_on_category_id", using: :btree
  add_index "contest_categories", ["contest_id"], name: "index_contest_categories_on_contest_id", using: :btree

  create_table "contests", force: :cascade do |t|
    t.integer  "season",           null: false
    t.integer  "level",            null: false
    t.integer  "host_id",          null: false
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

  create_table "instruments", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "participants", force: :cascade do |t|
    t.string   "first_name",   null: false
    t.string   "last_name",    null: false
    t.date     "birthdate",    null: false
    t.string   "street"
    t.string   "postal_code"
    t.string   "city"
    t.string   "country_code", null: false
    t.string   "phone",        null: false
    t.string   "email",        null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "performances", force: :cascade do |t|
    t.integer  "predecessor_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "contest_category_id", null: false
    t.datetime "stage_time"
    t.integer  "stage_venue_id"
  end

  add_index "performances", ["contest_category_id"], name: "index_performances_on_contest_category_id", using: :btree
  add_index "performances", ["predecessor_id"], name: "index_performances_on_predecessor_id", using: :btree
  add_index "performances", ["stage_venue_id"], name: "index_performances_on_stage_venue_id", using: :btree

  create_table "pieces", force: :cascade do |t|
    t.integer  "performance_id", null: false
    t.string   "title",          null: false
    t.string   "composer_name",  null: false
    t.string   "composer_born"
    t.string   "composer_died"
    t.string   "epoch",          null: false
    t.integer  "minutes",        null: false
    t.integer  "seconds",        null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "pieces", ["performance_id"], name: "index_pieces_on_performance_id", using: :btree

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
    t.string   "role",                                null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "venues", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "host_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "venues", ["host_id"], name: "index_venues_on_host_id", using: :btree

  add_foreign_key "appearances", "instruments"
  add_foreign_key "appearances", "participants"
  add_foreign_key "appearances", "performances"
  add_foreign_key "contest_categories", "categories"
  add_foreign_key "contest_categories", "contests"
  add_foreign_key "contests", "hosts"
  add_foreign_key "performances", "contest_categories"
  add_foreign_key "pieces", "performances"
  add_foreign_key "venues", "hosts"
end
