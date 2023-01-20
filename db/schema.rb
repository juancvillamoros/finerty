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

ActiveRecord::Schema[7.0].define(version: 2023_01_20_004117) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "salaries", force: :cascade do |t|
    t.decimal "amount"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_salaries_on_user_id"
  end

  create_table "salary_histories", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.decimal "amount"
    t.bigint "user_id", null: false
    t.bigint "salary_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["salary_id"], name: "index_salary_histories_on_salary_id"
    t.index ["user_id"], name: "index_salary_histories_on_user_id"
  end

  create_table "taxes", force: :cascade do |t|
    t.decimal "arl"
    t.decimal "salud"
    t.decimal "pension"
    t.decimal "fsp"
    t.decimal "cesantias"
    t.decimal "ccf"
    t.decimal "total"
    t.bigint "user_id", null: false
    t.bigint "salary_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["salary_id"], name: "index_taxes_on_salary_id"
    t.index ["user_id"], name: "index_taxes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "salaries", "users"
  add_foreign_key "salary_histories", "salaries"
  add_foreign_key "salary_histories", "users"
  add_foreign_key "taxes", "salaries"
  add_foreign_key "taxes", "users"
end
