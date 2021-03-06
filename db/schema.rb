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

ActiveRecord::Schema.define(version: 20140513065408) do

  create_table "attachments", force: true do |t|
    t.integer  "customer_id"
    t.string   "filename"
    t.integer  "filesize"
    t.string   "contenttype"
    t.string   "extension"
    t.binary   "rawdata",     limit: 16777215
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "banks", force: true do |t|
    t.string   "bankname"
    t.string   "branchname"
    t.string   "address"
    t.string   "accountnumber"
    t.string   "swiftcode"
    t.string   "holdername"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "bankcode"
    t.integer  "branchcode"
  end

  create_table "branches", force: true do |t|
    t.integer  "bank_id"
    t.string   "branchname"
    t.integer  "branchcode"
    t.string   "address"
    t.string   "swiftcode"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", force: true do |t|
    t.string   "accountid"
    t.string   "fullname"
    t.string   "password"
    t.string   "zipcode"
    t.string   "address"
    t.string   "country"
    t.date     "birthday"
    t.string   "sex"
    t.string   "nationality"
    t.string   "tel"
    t.string   "fax"
    t.string   "mobile"
    t.string   "email"
    t.string   "parentid"
    t.integer  "bank_id"
    t.integer  "service1"
    t.integer  "service2"
    t.string   "cbc"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "holderid"
    t.text     "remark"
    t.integer  "userclass"
  end

  create_table "users", force: true do |t|
    t.string   "username",               default: "", null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "role"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
