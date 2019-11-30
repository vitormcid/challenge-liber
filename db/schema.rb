# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_30_192202) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "automobiles", force: :cascade do |t|
    t.string "model"
    t.string "color"
    t.string "year"
    t.string "license_plate"
    t.string "kind"
    t.float "daily_cost"
  end

  create_table "cars", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "drivers_licenses", force: :cascade do |t|
    t.string "number"
    t.string "modalities"
    t.date "validiy"
  end

  create_table "locations", force: :cascade do |t|
    t.integer "people_id"
    t.integer "automobile_id"
    t.float "value"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "withdrawal_date"
    t.datetime "return_date"
  end

  create_table "people", force: :cascade do |t|
    t.string "name"
    t.string "last_name"
    t.string "document"
    t.string "email"
    t.date "birth_date"
    t.integer "driver_license_id"
  end

  create_table "phones", force: :cascade do |t|
    t.string "number"
    t.string "ddd"
    t.string "kind"
    t.boolean "preferential"
    t.integer "people_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
