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

ActiveRecord::Schema.define(version: 20150927141430) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "house_account_cycles", force: :cascade do |t|
    t.integer  "house_id"
    t.date     "from_date"
    t.date     "to_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "house_expense_per_tenants", force: :cascade do |t|
    t.integer  "house_expense_id"
    t.integer  "tenant_id"
    t.decimal  "amount"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "house_expense_templates", force: :cascade do |t|
    t.string   "expense_name"
    t.integer  "house_id"
    t.integer  "recurring_frequency_id"
    t.string   "recurring_frequency_value"
    t.date     "effective_from"
    t.date     "effective_to"
    t.boolean  "is_mandatory"
    t.decimal  "default_amount"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "default_payee_id"
  end

  create_table "house_expenses", force: :cascade do |t|
    t.integer  "tenant_id"
    t.integer  "house_expense_template_id"
    t.string   "expense_name"
    t.integer  "house_id"
    t.decimal  "amount"
    t.date     "spent_date"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "house_account_cycle_id"
  end

  create_table "house_settings", force: :cascade do |t|
    t.integer  "house_id"
    t.string   "setting_name"
    t.string   "setting_value"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "houses", force: :cascade do |t|
    t.string   "name"
    t.text     "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recurring_frequencies", force: :cascade do |t|
    t.string   "frequency"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "tenants", force: :cascade do |t|
    t.integer  "house_id"
    t.string   "name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
  end

end
