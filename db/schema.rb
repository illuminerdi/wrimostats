# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090715143431) do

  create_table "buddies", :force => true do |t|
    t.integer  "user_id"
    t.integer  "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "oh_snaps", :force => true do |t|
    t.integer  "word_war_id"
    t.integer  "user_id"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participants", :force => true do |t|
    t.integer  "word_war_id"
    t.integer  "uid"
    t.boolean  "is_willing",  :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "hashed_password"
    t.string   "salt"
    t.boolean  "can_has_notifications", :default => true
    t.integer  "uid"
    t.boolean  "is_admin",              :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "word_wars", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.boolean  "can_has_snaps", :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
