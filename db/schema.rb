# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_26_000136) do

  create_table "employees", force: :cascade do |t|
    t.string "name", limit: 10
    t.integer "job_group_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["job_group_id"], name: "index_employees_on_job_group_id"
  end

  create_table "job_groups", force: :cascade do |t|
    t.string "group_name", limit: 10
    t.decimal "rate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_name"], name: "index_job_groups_on_group_name", unique: true
  end

  create_table "time_report_records", force: :cascade do |t|
    t.string "report_date"
    t.string "datetime"
    t.decimal "hours_worked", precision: 5, scale: 2
    t.integer "employee_id", null: false
    t.integer "job_group_id", null: false
    t.integer "time_report_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_id"], name: "index_time_report_records_on_employee_id"
    t.index ["job_group_id"], name: "index_time_report_records_on_job_group_id"
    t.index ["time_report_id"], name: "index_time_report_records_on_time_report_id"
  end

  create_table "time_reports", force: :cascade do |t|
    t.string "name", limit: 20
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "employees", "job_groups"
  add_foreign_key "time_report_records", "employees"
  add_foreign_key "time_report_records", "job_groups"
  add_foreign_key "time_report_records", "time_reports"
end
