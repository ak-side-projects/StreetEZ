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

ActiveRecord::Schema.define(version: 20140421180805) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "rentals", force: true do |t|
    t.string   "title"
    t.integer  "num_bedrooms",  null: false
    t.integer  "num_bathrooms", null: false
    t.integer  "sq_footage",    null: false
    t.integer  "monthly_rent",  null: false
    t.text     "description"
    t.integer  "owner_id",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rentals", ["monthly_rent"], name: "index_rentals_on_monthly_rent", using: :btree
  add_index "rentals", ["num_bathrooms"], name: "index_rentals_on_num_bathrooms", using: :btree
  add_index "rentals", ["num_bedrooms"], name: "index_rentals_on_num_bedrooms", using: :btree
  add_index "rentals", ["owner_id"], name: "index_rentals_on_owner_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.string   "session_token",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
