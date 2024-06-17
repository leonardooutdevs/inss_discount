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

ActiveRecord::Schema[7.0].define(version: 2024_06_06_202112) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "access_levels", force: :cascade do |t|
    t.string "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.string "name", limit: 64, null: false
    t.string "kind", limit: 64, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["kind"], name: "index_access_levels_on_kind", unique: true
    t.index ["uuid"], name: "index_access_levels_on_uuid", unique: true
  end

  create_table "access_permission_levels", force: :cascade do |t|
    t.string "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "access_permission_id", null: false
    t.bigint "access_level_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["access_level_id"], name: "index_access_permission_levels_on_access_level_id"
    t.index ["access_permission_id", "access_level_id"], name: "index_apl_on_ap_id_and_al_id", unique: true
    t.index ["access_permission_id"], name: "index_access_permission_levels_on_access_permission_id"
    t.index ["uuid"], name: "index_access_permission_levels_on_uuid", unique: true
  end

  create_table "access_permissions", force: :cascade do |t|
    t.string "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.string "name", limit: 64, null: false
    t.string "model", limit: 64, null: false
    t.string "status", default: "active", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["model"], name: "index_access_permissions_on_model", unique: true
    t.index ["uuid"], name: "index_access_permissions_on_uuid", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.string "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "city_id", null: false
    t.string "address", limit: 128, default: "", null: false
    t.string "number", limit: 32
    t.string "complement", limit: 32
    t.string "neighborhood", limit: 128, default: "", null: false
    t.string "zip_code", limit: 32, default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id", "address", "number", "complement", "neighborhood", "zip_code"], name: "index_addresses_on_city_and_details", unique: true
    t.index ["city_id"], name: "index_addresses_on_city_id"
    t.index ["uuid"], name: "index_addresses_on_uuid", unique: true
  end

  create_table "cities", force: :cascade do |t|
    t.string "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "state_id", null: false
    t.string "ibge_code", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "state_id"], name: "index_cities_on_name_and_state_id", unique: true
    t.index ["state_id"], name: "index_cities_on_state_id"
    t.index ["uuid"], name: "index_cities_on_uuid", unique: true
  end

  create_table "countries", force: :cascade do |t|
    t.string "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uuid"], name: "index_countries_on_uuid", unique: true
  end

  create_table "phones", force: :cascade do |t|
    t.string "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.string "number", limit: 32, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["number"], name: "index_phones_on_number", unique: true
    t.index ["uuid"], name: "index_phones_on_uuid", unique: true
  end

  create_table "proponent_addresses", force: :cascade do |t|
    t.bigint "proponent_id", null: false
    t.bigint "address_id", null: false
    t.string "kind", default: "residential", null: false
    t.string "status", default: "active", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_proponent_addresses_on_address_id"
    t.index ["proponent_id", "address_id", "kind"], name: "index_proponent_addresses_on_proponent_id_and_details", unique: true
    t.index ["proponent_id"], name: "index_proponent_addresses_on_proponent_id"
  end

  create_table "proponent_phones", force: :cascade do |t|
    t.bigint "proponent_id", null: false
    t.bigint "phone_id", null: false
    t.string "kind", default: "residential", null: false
    t.string "status", default: "active", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["phone_id"], name: "index_proponent_phones_on_phone_id"
    t.index ["proponent_id", "phone_id"], name: "index_proponent_phones_on_proponent_id_and_phone_id", unique: true
    t.index ["proponent_id"], name: "index_proponent_phones_on_proponent_id"
  end

  create_table "proponents", force: :cascade do |t|
    t.string "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "salary_id", null: false
    t.decimal "gross_salary", null: false
    t.decimal "discount", null: false
    t.decimal "net_salary", null: false
    t.string "name", limit: 128, null: false
    t.string "document", limit: 64, null: false
    t.date "birth_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document"], name: "index_proponents_on_document", unique: true
    t.index ["salary_id"], name: "index_proponents_on_salary_id"
    t.index ["uuid"], name: "index_proponents_on_uuid", unique: true
    t.check_constraint "document::text ~ '^\\d+$'::text", name: "check_numeric_document"
  end

  create_table "salaries", force: :cascade do |t|
    t.string "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.string "salary_range", null: false
    t.decimal "max_amount", default: "0.0", null: false
    t.decimal "min_amount", default: "0.0", null: false
    t.decimal "calculation_basis", default: "0.0", null: false
    t.string "status", default: "active", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["salary_range", "calculation_basis"], name: "index_salaries_on_salary_range_and_calculation_basis", unique: true
    t.index ["uuid"], name: "index_salaries_on_uuid", unique: true
  end

  create_table "states", force: :cascade do |t|
    t.string "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "country_id", null: false
    t.string "ibge_code", null: false
    t.string "name", null: false
    t.string "uf", limit: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_states_on_country_id"
    t.index ["name", "country_id"], name: "index_states_on_name_and_country_id", unique: true
    t.index ["uuid"], name: "index_states_on_uuid", unique: true
  end

  create_table "user_accesses", force: :cascade do |t|
    t.string "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "user_id", null: false
    t.bigint "access_permission_level_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["access_permission_level_id"], name: "index_user_accesses_on_access_permission_level_id"
    t.index ["user_id", "access_permission_level_id"], name: "index_user_accesses_on_user_id_and_access_permission_level_id", unique: true
    t.index ["user_id"], name: "index_user_accesses_on_user_id"
    t.index ["uuid"], name: "index_user_accesses_on_uuid", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uuid"], name: "index_users_on_uuid", unique: true
  end

  add_foreign_key "access_permission_levels", "access_levels"
  add_foreign_key "access_permission_levels", "access_permissions"
  add_foreign_key "addresses", "cities"
  add_foreign_key "cities", "states"
  add_foreign_key "proponent_addresses", "addresses"
  add_foreign_key "proponent_addresses", "proponents"
  add_foreign_key "proponent_phones", "phones"
  add_foreign_key "proponent_phones", "proponents"
  add_foreign_key "proponents", "salaries"
  add_foreign_key "states", "countries"
  add_foreign_key "user_accesses", "access_permission_levels"
  add_foreign_key "user_accesses", "users"
end
