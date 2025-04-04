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

ActiveRecord::Schema[7.2].define(version: 2024_11_22_012259) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "employees", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "restaurant_id", null: false
    t.string "name"
    t.string "cpf"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status"
    t.index ["email"], name: "index_employees_on_email", unique: true
    t.index ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true
    t.index ["restaurant_id"], name: "index_employees_on_restaurant_id"
  end

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
    t.date "start_date"
    t.date "end_date"
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

  create_table "order_items", force: :cascade do |t|
    t.string "note"
    t.integer "order_id", null: false
    t.integer "serving_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["serving_id"], name: "index_order_items_on_serving_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "customer_name"
    t.string "contact_phone"
    t.string "contact_email"
    t.string "cpf"
    t.string "code"
    t.integer "status"
    t.integer "restaurant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_orders_on_restaurant_id"
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

  create_table "status_historics", force: :cascade do |t|
    t.integer "order_id", null: false
    t.string "status", null: false
    t.datetime "changed_at", null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_status_historics_on_order_id"
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "employees", "restaurants"
  add_foreign_key "markers", "restaurants"
  add_foreign_key "menu_contents", "menu_items"
  add_foreign_key "menu_contents", "menus"
  add_foreign_key "menu_item_markers", "markers"
  add_foreign_key "menu_item_markers", "menu_items"
  add_foreign_key "menu_items", "restaurants"
  add_foreign_key "menus", "restaurants"
  add_foreign_key "operating_days", "restaurants"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "servings"
  add_foreign_key "orders", "restaurants"
  add_foreign_key "price_histories", "servings"
  add_foreign_key "restaurants", "users"
  add_foreign_key "servings", "menu_items"
  add_foreign_key "status_historics", "orders"
end
