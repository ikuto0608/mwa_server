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

ActiveRecord::Schema.define(version: 20161024025937) do

  create_table "exams", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "result_array"
    t.integer  "result_time"
    t.text     "volatile_json"
  end

  create_table "topics", force: true do |t|
    t.string   "question"
    t.text     "question_array"
    t.text     "index_array_of_answer"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "exam_id"
    t.text     "volatile_json"
    t.text     "description"
  end

  add_index "topics", ["exam_id"], name: "index_topics_on_exam_id"

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "name"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
