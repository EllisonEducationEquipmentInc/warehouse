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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130506002748) do

  create_table "customers", :force => true do |t|
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
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "customers", ["ax_customer_number"], :name => "index_customers_on_ax_customer_number"
  add_index "customers", ["company_name"], :name => "index_customers_on_company_name"
  add_index "customers", ["zip"], :name => "index_customers_on_zip"

  create_table "order_items", :force => true do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.decimal  "price",      :precision => 6,  :scale => 2
    t.integer  "quantity",                                  :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "item_total", :precision => 10, :scale => 2
    t.date     "ship_month"
  end

  create_table "orders", :force => true do |t|
    t.string   "email"
    t.decimal  "sub_total",         :precision => 12, :scale => 2
    t.decimal  "sales_tax",         :precision => 6,  :scale => 2
    t.decimal  "total",             :precision => 12, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "business"
    t.string   "contact"
    t.string   "phone"
    t.string   "address"
    t.text     "notes"
    t.boolean  "tax_exempt",                                       :default => false
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
  end

  create_table "products", :force => true do |t|
    t.string   "item_num"
    t.string   "name"
    t.string   "upc"
    t.decimal  "price",          :precision => 6,  :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "start_date"
    t.integer  "min_qty",                                       :default => 1
    t.boolean  "deleted",                                       :default => false
    t.string   "coupon_1"
    t.string   "coupon_2"
    t.decimal  "coupon_price_1", :precision => 10, :scale => 0
    t.decimal  "coupon_price_2", :precision => 10, :scale => 0
    t.string   "coupon_3"
    t.string   "coupon_4"
    t.string   "coupon_5"
    t.decimal  "coupon_price_3", :precision => 10, :scale => 0
    t.decimal  "coupon_price_4", :precision => 10, :scale => 0
    t.decimal  "coupon_price_5", :precision => 10, :scale => 0
  end

  add_index "products", ["item_num"], :name => "index_products_on_item_num"
  add_index "products", ["upc"], :name => "index_products_on_upc"

end
