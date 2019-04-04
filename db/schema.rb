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

ActiveRecord::Schema.define(version: 2019_04_04_065510) do

  create_table "connections", force: :cascade do |t|
    t.integer "from_id", null: false
    t.integer "to_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["from_id", "to_id"], name: "index_connections_on_from_id_and_to_id", unique: true
    t.index ["from_id"], name: "index_connections_on_from_id"
    t.index ["to_id"], name: "index_connections_on_to_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "nickname"
    t.string "uuid"
    t.integer "team"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "connection_token"
    t.index ["uuid"], name: "index_users_on_uuid", unique: true
  end

end
