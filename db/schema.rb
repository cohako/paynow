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

ActiveRecord::Schema.define(version: 2021_06_16_003044) do

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "boleto_accounts", force: :cascade do |t|
    t.integer "bank_code"
    t.integer "agency_code"
    t.integer "account_number"
    t.integer "client_company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "payment_method_id", null: false
    t.index ["client_company_id"], name: "index_boleto_accounts_on_client_company_id"
    t.index ["payment_method_id"], name: "index_boleto_accounts_on_payment_method_id"
  end

  create_table "card_accounts", force: :cascade do |t|
    t.integer "contract_number"
    t.integer "client_company_id", null: false
    t.integer "payment_method_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_company_id"], name: "index_card_accounts_on_client_company_id"
    t.index ["payment_method_id"], name: "index_card_accounts_on_payment_method_id"
  end

  create_table "client_companies", force: :cascade do |t|
    t.integer "cnpj", null: false
    t.string "name", null: false
    t.text "billing_address", null: false
    t.string "billing_email", null: false
    t.string "token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "admin"
    t.string "domain"
  end

  create_table "client_ext_companies", force: :cascade do |t|
    t.integer "client_company_id", null: false
    t.integer "client_external_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_company_id"], name: "index_client_ext_companies_on_client_company_id"
    t.index ["client_external_id"], name: "index_client_ext_companies_on_client_external_id"
  end

  create_table "client_externals", force: :cascade do |t|
    t.string "name"
    t.integer "cpf"
    t.string "client_external_token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "client_products", force: :cascade do |t|
    t.string "name"
    t.decimal "price"
    t.decimal "pix_discount"
    t.decimal "card_discount"
    t.decimal "boleto_discount"
    t.string "product_token"
    t.integer "client_company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_company_id"], name: "index_client_products_on_client_company_id"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string "name"
    t.integer "payment_type"
    t.decimal "payment_fee"
    t.decimal "max_monetary_fee"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0, null: false
  end

  create_table "pix_accounts", force: :cascade do |t|
    t.string "pix_code"
    t.integer "payment_method_id", null: false
    t.integer "client_company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_company_id"], name: "index_pix_accounts_on_client_company_id"
    t.index ["payment_method_id"], name: "index_pix_accounts_on_payment_method_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "roles", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "client_company_id"
    t.index ["client_company_id"], name: "index_users_on_client_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "boleto_accounts", "client_companies"
  add_foreign_key "boleto_accounts", "payment_methods"
  add_foreign_key "card_accounts", "client_companies"
  add_foreign_key "card_accounts", "payment_methods"
  add_foreign_key "client_ext_companies", "client_companies"
  add_foreign_key "client_ext_companies", "client_externals"
  add_foreign_key "client_products", "client_companies"
  add_foreign_key "pix_accounts", "client_companies"
  add_foreign_key "pix_accounts", "payment_methods"
  add_foreign_key "users", "client_companies"
end
