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

ActiveRecord::Schema.define(version: 20140423021939) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: true do |t|
    t.integer  "rental_id",  null: false
    t.string   "street",     null: false
    t.string   "unit",       null: false
    t.string   "city",       null: false
    t.string   "state",      null: false
    t.integer  "zipcode",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "addresses", ["rental_id"], name: "index_addresses_on_rental_id", using: :btree

  create_table "messages", force: true do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["recipient_id"], name: "index_messages_on_recipient_id", using: :btree
  add_index "messages", ["sender_id"], name: "index_messages_on_sender_id", using: :btree

  create_table "notifications", force: true do |t|
    t.integer  "notifiable_id",   null: false
    t.string   "notifiable_type", null: false
    t.integer  "event_id",        null: false
    t.integer  "user_id",         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notifications", ["event_id"], name: "index_notifications_on_event_id", using: :btree
  add_index "notifications", ["notifiable_id"], name: "index_notifications_on_notifiable_id", using: :btree
  add_index "notifications", ["notifiable_type"], name: "index_notifications_on_notifiable_type", using: :btree
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "photos", force: true do |t|
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.integer  "rental_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photos", ["rental_id"], name: "index_photos_on_rental_id", using: :btree

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
    t.string   "neighborhood",  null: false
  end

  add_index "rentals", ["monthly_rent"], name: "index_rentals_on_monthly_rent", using: :btree
  add_index "rentals", ["num_bathrooms"], name: "index_rentals_on_num_bathrooms", using: :btree
  add_index "rentals", ["num_bedrooms"], name: "index_rentals_on_num_bedrooms", using: :btree
  add_index "rentals", ["owner_id"], name: "index_rentals_on_owner_id", using: :btree

  create_table "saved_rentals", force: true do |t|
    t.integer  "user_id",    null: false
    t.integer  "rental_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "saved_rentals", ["rental_id"], name: "index_saved_rentals_on_rental_id", using: :btree
  add_index "saved_rentals", ["user_id"], name: "index_saved_rentals_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.string   "session_token",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",            null: false
  end

end
