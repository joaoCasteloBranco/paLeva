# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_11_08_113928) do
  create_table "markers", force: :cascade do |t|
    t.string "name"
    t.integer "restaurant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_markers_on_restaurant_id"
  end

  create_table "menu_contents", force: :cascade do |t|
    t.integer "menu_id", null: false
    t.integer "menu_item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_id"], name: "index_menu_contents_on_menu_id"
    t.index ["menu_item_id"], name: "index_menu_contents_on_menu_item_id"
  end

  create_table "menu_item_markers", force: :cascade do |t|
    t.integer "menu_item_id", null: false
    t.integer "marker_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["marker_id"], name: "index_menu_item_markers_on_marker_id"
    t.index ["menu_item_id"], name: "index_menu_item_markers_on_menu_item_id"
  end

  create_table "menu_items", force: :cascade do |t|
    t.string "type"
    t.string "name"
    t.text "description"
    t.integer "status", default: 1
    t.integer "calories"
    t.string "photo"
    t.integer "restaurant_id", null: false
    t.boolean "alcoholic"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_menu_items_on_restaurant_id"
  end

  create_table "menus", force: :cascade do |t|
    t.string "name"
    t.integer "restaurant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_menus_on_restaurant_id"
  end

  create_table "operating_days", force: :cascade do |t|
    t.integer "restaurant_id", null: false
    t.integer "week_day"
    t.boolean "open"
    t.time "opening_time"
    t.time "closing_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_operating_days_on_restaurant_id"
  end

  create_table "price_histories", force: :cascade do |t|
    t.integer "serving_id", null: false
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "changed_at"
    t.index ["serving_id"], name: "index_price_histories_on_serving_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "registered_name"
    t.string "comercial_name"
    t.string "cnpj"
    t.text "address"
    t.string "phone"
    t.string "email"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_restaurants_on_user_id"
  end

  create_table "servings", force: :cascade do |t|
    t.integer "menu_item_id", null: false
    t.string "description"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_item_id"], name: "index_servings_on_menu_item_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "cpf"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "markers", "restaurants"
  add_foreign_key "menu_contents", "menu_items"
  add_foreign_key "menu_contents", "menus"
  add_foreign_key "menu_item_markers", "markers"
  add_foreign_key "menu_item_markers", "menu_items"
  add_foreign_key "menu_items", "restaurants"
  add_foreign_key "menus", "restaurants"
  add_foreign_key "operating_days", "restaurants"
  add_foreign_key "price_histories", "servings"
  add_foreign_key "restaurants", "users"
  add_foreign_key "servings", "menu_items"
end
