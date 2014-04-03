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

ActiveRecord::Schema.define(version: 20140403135301) do

  create_table "dishes", force: true do |t|
    t.string   "dish_name"
    t.text     "dish_steps"
    t.float    "dish_protein"
    t.float    "dish_fat"
    t.float    "dish_carbs"
    t.integer  "dish_calories"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_id"
  end

  add_index "dishes", ["user_id"], name: "index_dishes_on_user_id"

  create_table "ingredients", force: true do |t|
    t.integer  "product_id"
    t.integer  "dish_id"
    t.float    "quantity_per_dish"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ingredients", ["dish_id"], name: "index_ingredients_on_dish_id"
  add_index "ingredients", ["product_id"], name: "index_ingredients_on_product_id"

  create_table "meal_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "meal_types", ["user_id"], name: "index_meal_types_on_user_id"

  create_table "meals", force: true do |t|
    t.integer  "meal_type_id"
    t.integer  "dish_id"
    t.integer  "menu_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "meals", ["dish_id"], name: "index_meals_on_dish_id"
  add_index "meals", ["meal_type_id"], name: "index_meals_on_meal_type_id"
  add_index "meals", ["menu_id"], name: "index_meals_on_menu_id"

  create_table "menus", force: true do |t|
    t.date     "menu_date"
    t.integer  "meals_count",   default: 0
    t.integer  "menu_calories"
    t.float    "menu_protein"
    t.float    "menu_fat"
    t.float    "menu_carbs"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "menus", ["user_id"], name: "index_menus_on_user_id"

  create_table "products", force: true do |t|
    t.string   "product_name"
    t.integer  "product_calories"
    t.float    "product_protein"
    t.float    "product_fat"
    t.float    "product_carbs"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "products", ["user_id"], name: "index_products_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
