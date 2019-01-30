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

ActiveRecord::Schema.define(:version => 20121024222353) do

  create_table "countries", :id => false, :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "countries", ["code"], :name => "index_countries_on_code", :unique => true

  create_table "currencies", :id => false, :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "country_id"
  end

  add_index "currencies", ["code"], :name => "index_currencies_on_code", :unique => true

  create_table "user_countries", :force => true do |t|
    t.string   "country_code"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_countries", ["country_code", "user_id"], :name => "index_user_countries_on_country_code_and_user_id"

  create_table "user_currencies", :force => true do |t|
    t.string   "currency_code"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_currencies", ["currency_code", "user_id"], :name => "index_user_currencies_on_currency_code_and_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",              :limit => 50
    t.string   "encrypted_password", :limit => 250
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_salt"
  end

end
