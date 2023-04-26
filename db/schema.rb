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

ActiveRecord::Schema[7.0].define(version: 2023_04_26_150402) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "images", force: :cascade do |t|
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "item_id", null: false
    t.index ["item_id"], name: "index_images_on_item_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.decimal "buying_price"
    t.decimal "selling_price"
    t.integer "quantity"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items_orders", id: false, force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "order_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id", "order_id"], name: "index_items_orders_on_item_id_and_order_id"
    t.index ["order_id", "item_id"], name: "index_items_orders_on_order_id_and_item_id"
  end

  create_table "items_sales", id: false, force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "sale_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id", "sale_id"], name: "index_items_sales_on_item_id_and_sale_id"
    t.index ["sale_id", "item_id"], name: "index_items_sales_on_sale_id_and_item_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "pic"
    t.decimal "total_price"
    t.string "status"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "sales", force: :cascade do |t|
    t.string "seller"
    t.decimal "total_price"
    t.datetime "date"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sales_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "images", "items"
  add_foreign_key "orders", "users"
  add_foreign_key "sales", "users"
end
