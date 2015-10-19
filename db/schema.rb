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

ActiveRecord::Schema.define(version: 20151017223544) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "opponent_team_id"
    t.integer  "match_id"
    t.integer  "team_score"
    t.integer  "opponent_team_score"
    t.datetime "on_date"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "games", ["match_id"], name: "index_games_on_match_id", using: :btree
  add_index "games", ["opponent_team_id"], name: "index_games_on_opponent_team_id", using: :btree
  add_index "games", ["team_id"], name: "index_games_on_team_id", using: :btree

  create_table "matches", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.integer  "match_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "teams", ["match_id"], name: "index_teams_on_match_id", using: :btree

  create_table "user_scores", force: :cascade do |t|
    t.integer  "score"
    t.integer  "user_team_id"
    t.datetime "on_date"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "game_id"
  end

  add_index "user_scores", ["game_id"], name: "index_user_scores_on_game_id", using: :btree
  add_index "user_scores", ["user_team_id"], name: "index_user_scores_on_user_team_id", using: :btree

  create_table "user_teams", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_teams", ["team_id"], name: "index_user_teams_on_team_id", using: :btree
  add_index "user_teams", ["user_id"], name: "index_user_teams_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",                  default: "",    null: false
    t.boolean  "is_admin",               default: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_foreign_key "games", "matches"
  add_foreign_key "teams", "matches"
  add_foreign_key "user_scores", "games"
  add_foreign_key "user_scores", "user_teams"
  add_foreign_key "user_teams", "teams"
  add_foreign_key "user_teams", "users"
end
