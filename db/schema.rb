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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111205015830) do

  create_table "authorizations", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "name"
    t.string   "nickname"
  end

  create_table "conversation_user_settings", :force => true do |t|
    t.integer  "conversation_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conversations", :force => true do |t|
    t.integer  "link_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visitor_id"
  end

  create_table "fb_education_nodes", :force => true do |t|
    t.string   "school"
    t.string   "year"
    t.string   "school_type"
    t.string   "degree"
    t.integer  "fb_user_node_id"
    t.boolean  "show"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fb_user_nodes", :force => true do |t|
    t.string   "picture"
    t.string   "name"
    t.string   "link"
    t.string   "username"
    t.string   "gender"
    t.string   "email"
    t.string   "verified"
    t.string   "updated_time"
    t.string   "hometown"
    t.string   "location"
    t.boolean  "show_picture"
    t.boolean  "show_name"
    t.boolean  "show_gender"
    t.boolean  "show_hometown"
    t.boolean  "show_location"
    t.integer  "link_user_setting_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fb_work_nodes", :force => true do |t|
    t.string   "employer"
    t.string   "position"
    t.string   "location"
    t.string   "start_date"
    t.string   "end_date"
    t.integer  "fb_user_node_id"
    t.boolean  "show"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "link_user_settings", :force => true do |t|
    t.integer  "link_id"
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "links", :force => true do |t|
    t.string   "url"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
  end

  create_table "messages", :force => true do |t|
    t.string   "subject"
    t.string   "body"
    t.integer  "conversation_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "salt"
  end

end
