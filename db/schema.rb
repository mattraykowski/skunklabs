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

ActiveRecord::Schema.define(version: 20160219155658) do

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "lab_id"
    t.text     "comment"
    t.string   "subject"
    t.boolean  "is_update"
    t.integer  "progress"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "focus_types", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lab_supporters", force: true do |t|
    t.integer  "user_id",    null: false
    t.integer  "lab_id",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lab_supporters", ["user_id", "lab_id"], name: "index_lab_supporters_on_user_id_and_lab_id", unique: true

  create_table "labs", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "goals"
    t.text     "measurements"
    t.integer  "focus_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",        default: 0, null: false
  end

  create_table "link_resources", force: true do |t|
    t.integer  "lab_id"
    t.string   "name"
    t.string   "url"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "role_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "suggestion_states", force: true do |t|
    t.string   "name",                       null: false
    t.boolean  "done",       default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "suggestion_votes", force: true do |t|
    t.integer  "suggestion_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "suggestions", force: true do |t|
    t.string   "title",                       null: false
    t.text     "description",                 null: false
    t.integer  "creator_id",                  null: false
    t.integer  "team_member_id"
    t.integer  "status_id",       default: 0, null: false
    t.datetime "completion_date"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "team_roles", force: true do |t|
    t.integer  "lab_id"
    t.integer  "role_type_id"
    t.integer  "user_id"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "login",                  default: "",    null: false
    t.string   "remember_token"
    t.string   "displayname"
    t.string   "job_title"
    t.string   "department"
    t.boolean  "admin",                  default: false, null: false
    t.boolean  "suggestion_team_member", default: false
    t.boolean  "meeting_notice",         default: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["login"], name: "index_users_on_login", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
