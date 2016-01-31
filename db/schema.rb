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

ActiveRecord::Schema.define(version: 20160131080615) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "mesin_emails", force: :cascade do |t|
    t.string   "email",      limit: 100, null: false
    t.integer  "user_id"
    t.string   "label",      limit: 20
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "mesin_emails", ["email"], name: "index_mesin_emails_on_email", unique: true, using: :btree
  add_index "mesin_emails", ["user_id"], name: "index_mesin_emails_on_user_id", using: :btree

  create_table "mesin_profiles", force: :cascade do |t|
    t.integer  "user_id",                              null: false
    t.string   "username",    limit: 100,              null: false
    t.string   "fullname",                default: ""
    t.date     "birthdate"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "websites",    limit: 100
    t.string   "homephone",   limit: 12
    t.string   "mobilephone", limit: 12
    t.string   "address",     limit: 350
  end

  add_index "mesin_profiles", ["user_id"], name: "index_mesin_profiles_on_user_id", using: :btree

  create_table "mesin_role_users", force: :cascade do |t|
    t.integer  "role_id",    null: false
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "mesin_role_users", ["role_id", "user_id"], name: "index_mesin_role_users_on_role_id_and_user_id", unique: true, using: :btree

  create_table "mesin_roles", force: :cascade do |t|
    t.string   "role_name",         limit: 50,                null: false
    t.boolean  "it_can_be_deleted",            default: true, null: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.integer  "role_id_parent",               default: 0
    t.string   "role_title",        limit: 50
  end

  add_index "mesin_roles", ["role_name"], name: "index_mesin_roles_on_role_name", unique: true, using: :btree

  create_table "mesin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role",                                null: false
  end

  add_index "mesin_users", ["confirmation_token"], name: "index_mesin_users_on_confirmation_token", unique: true, using: :btree
  add_index "mesin_users", ["email"], name: "index_mesin_users_on_email", unique: true, using: :btree
  add_index "mesin_users", ["reset_password_token"], name: "index_mesin_users_on_reset_password_token", unique: true, using: :btree
  add_index "mesin_users", ["role"], name: "index_mesin_users_on_role", using: :btree
  add_index "mesin_users", ["unlock_token"], name: "index_mesin_users_on_unlock_token", unique: true, using: :btree

  add_foreign_key "mesin_emails", "mesin_users", column: "user_id"
  add_foreign_key "mesin_role_users", "mesin_roles", column: "role_id"
  add_foreign_key "mesin_role_users", "mesin_users", column: "user_id"
end
