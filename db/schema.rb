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

ActiveRecord::Schema[8.1].define(version: 2026_02_12_162627) do
  create_table "assignments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "employee_id"
    t.float "hours_onsite"
    t.integer "project_id"
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_assignments_on_employee_id"
    t.index ["project_id"], name: "index_assignments_on_project_id"
  end

  create_table "employees", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.date "hire_date"
    t.string "name", null: false
    t.string "phone"
    t.string "role", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_employees_on_email", unique: true
  end

  create_table "project_vehicles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string "address"
    t.datetime "created_at", null: false
    t.string "customer_name"
    t.date "date_ended"
    t.date "date_started"
    t.text "desc"
    t.string "employees"
    t.text "equipment_onsite"
    t.float "estimates"
    t.float "hours_onsite"
    t.string "job_type"
    t.text "materials"
    t.float "net_cost"
    t.datetime "updated_at", null: false
  end

  create_table "vehicles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "model"
    t.string "nick_name"
    t.datetime "updated_at", null: false
    t.integer "year"
  end

  add_foreign_key "assignments", "employees"
  add_foreign_key "assignments", "projects"
end
