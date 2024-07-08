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

ActiveRecord::Schema[7.1].define(version: 2024_07_08_154624) do
  create_table "lesson_students", force: :cascade do |t|
    t.integer "lesson_id", null: false
    t.integer "student_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lesson_id", "student_id"], name: "index_lesson_students_on_lesson_id_and_student_id", unique: true
    t.index ["lesson_id"], name: "index_lesson_students_on_lesson_id"
    t.index ["student_id"], name: "index_lesson_students_on_student_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.date "start_date"
    t.date "end_date"
    t.time "start_time"
    t.time "end_time"
    t.integer "teacher_id", null: false
    t.integer "lounge_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["lounge_id"], name: "index_lessons_on_lounge_id"
    t.index ["teacher_id"], name: "index_lessons_on_teacher_id"
    t.index ["user_id"], name: "index_lessons_on_user_id"
  end

  create_table "lounges", force: :cascade do |t|
    t.string "name"
    t.integer "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_lounges_on_user_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "document_number"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_students_on_user_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "document_number"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_teachers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.integer "document_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "lesson_students", "lessons"
  add_foreign_key "lesson_students", "students"
  add_foreign_key "lessons", "lounges"
  add_foreign_key "lessons", "teachers"
  add_foreign_key "lessons", "users"
  add_foreign_key "lounges", "users"
  add_foreign_key "students", "users"
  add_foreign_key "teachers", "users"
end
