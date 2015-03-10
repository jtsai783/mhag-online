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

ActiveRecord::Schema.define(version: 20150307204852) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_skill_aliases", force: :cascade do |t|
    t.integer  "active_skill_id"
    t.string   "alias"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "active_skills", force: :cascade do |t|
    t.string   "name"
    t.integer  "skill_id"
    t.integer  "points"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "display_alias"
  end

  create_table "armor_skills", force: :cascade do |t|
    t.integer  "armor_id"
    t.integer  "skill_id"
    t.integer  "points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "armors", force: :cascade do |t|
    t.string   "name"
    t.integer  "sex"
    t.integer  "klass"
    t.integer  "rarity"
    t.integer  "slots",          default: 0, null: false
    t.integer  "avail_online"
    t.integer  "avail_offline"
    t.integer  "initial_def"
    t.integer  "final_def"
    t.integer  "fire_resist"
    t.integer  "water_resist"
    t.integer  "thunder_resist"
    t.integer  "ice_resist"
    t.integer  "dragon_resist"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "user_id"
    t.string   "armor_type"
  end

  create_table "dec_skills", force: :cascade do |t|
    t.integer  "skill_id"
    t.integer  "decoration_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "points"
  end

  create_table "decorations", force: :cascade do |t|
    t.string   "name"
    t.integer  "rarity"
    t.integer  "slots"
    t.integer  "avail_online"
    t.integer  "avail_offline"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "skill_aliases", force: :cascade do |t|
    t.integer  "skill_id"
    t.string   "alias"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skills", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "alias_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",        null: false
    t.string   "password_digest", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
