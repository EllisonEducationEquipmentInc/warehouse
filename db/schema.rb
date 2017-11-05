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

ActiveRecord::Schema.define(version: 20171104221751) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.string   "ax_customer_number"
    t.string   "company_name"
    t.string   "full_name"
    t.string   "customer_class"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "customers", ["ax_customer_number"], name: "index_customers_on_ax_customer_number", using: :btree
  add_index "customers", ["company_name"], name: "index_customers_on_company_name", using: :btree
  add_index "customers", ["zip"], name: "index_customers_on_zip", using: :btree

  create_table "order_items", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.decimal  "price",      precision: 6,  scale: 2
    t.integer  "quantity",                            default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "item_total", precision: 10, scale: 2
    t.date     "ship_month"
  end

  create_table "orders", force: :cascade do |t|
    t.string   "email"
    t.decimal  "sub_total",         precision: 12, scale: 2
    t.decimal  "sales_tax",         precision: 6,  scale: 2
    t.decimal  "total",             precision: 12, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "business"
    t.string   "contact"
    t.string   "phone"
    t.string   "address"
    t.text     "notes"
    t.boolean  "tax_exempt",                                 default: false
    t.string   "tax_exempt_number"
    t.string   "payment_method"
    t.string   "customer_number"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "country"
    t.string   "employee_number"
    t.string   "full_name"
    t.string   "coupon_code"
    t.decimal  "discount_amount",   precision: 12, scale: 2, default: 0.0
  end

  create_table "products", force: :cascade do |t|
    t.string   "item_num"
    t.string   "name"
    t.string   "upc"
    t.decimal  "price",          precision: 6, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "start_date"
    t.integer  "min_qty",                                default: 1
    t.boolean  "deleted",                                default: false
    t.string   "coupon_1"
    t.string   "coupon_2"
    t.decimal  "coupon_price_1", precision: 6, scale: 2
    t.decimal  "coupon_price_2", precision: 6, scale: 2
    t.string   "coupon_3"
    t.string   "coupon_4"
    t.string   "coupon_5"
    t.decimal  "coupon_price_3", precision: 6, scale: 2
    t.decimal  "coupon_price_4", precision: 6, scale: 2
    t.decimal  "coupon_price_5", precision: 6, scale: 2
    t.text     "designer"
  end

  add_index "products", ["item_num"], name: "index_products_on_item_num", using: :btree
  add_index "products", ["upc"], name: "index_products_on_upc", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                   default: "", null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "role"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "employee_number"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

end
