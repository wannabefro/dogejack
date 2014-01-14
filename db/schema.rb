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

ActiveRecord::Schema.define(version: 20140109190751) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: true do |t|
    t.string "value", null: false
    t.string "suit",  null: false
  end

  create_table "deck_cards", force: true do |t|
    t.integer  "deck_id"
    t.integer  "card_id"
    t.boolean  "played",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "deck_cards", ["deck_id", "card_id"], name: "index_deck_cards_on_deck_id_and_card_id", unique: true, using: :btree

  create_table "decks", force: true do |t|
    t.integer  "game_session_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "decks", ["game_session_id"], name: "index_decks_on_game_session_id", using: :btree

  create_table "game_sessions", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", force: true do |t|
    t.integer  "user_id",                             null: false
    t.string   "state",           default: "started"
    t.string   "player_cards",    default: [],                     array: true
    t.string   "dealer_cards",    default: [],                     array: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "winner"
    t.integer  "bet",             default: 0,         null: false
    t.integer  "game_session_id",                     null: false
    t.string   "split_cards",     default: [],                     array: true
    t.string   "split_bets",      default: [],                     array: true
    t.boolean  "split",           default: false
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "username",               default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string   "authentication_token"
    t.integer  "games_count",            default: 0,  null: false
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "wallets", force: true do |t|
    t.integer  "user_id",                null: false
    t.integer  "balance",    default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wallets", ["user_id"], name: "index_wallets_on_user_id", unique: true, using: :btree

end
