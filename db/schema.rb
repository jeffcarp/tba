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

ActiveRecord::Schema.define(:version => 20121128054605) do

  create_table "accounts", :force => true do |t|
    t.string    "provider"
    t.string    "uid"
    t.integer   "user_id"
    t.timestamp "created_at",                   :null => false
    t.timestamp "updated_at",                   :null => false
    t.string    "email"
    t.boolean   "receive",    :default => true
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer   "priority",   :default => 0
    t.integer   "attempts",   :default => 0
    t.text      "handler"
    t.text      "last_error"
    t.timestamp "run_at"
    t.timestamp "locked_at"
    t.timestamp "failed_at"
    t.string    "locked_by"
    t.string    "queue"
    t.timestamp "created_at",                :null => false
    t.timestamp "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "issues", :force => true do |t|
    t.date      "publish_date"
    t.timestamp "created_at",                      :null => false
    t.timestamp "updated_at",                      :null => false
    t.boolean   "published",    :default => false
    t.text      "foss"
    t.text      "dana"
    t.text      "bobs"
    t.text      "foss_dinner"
    t.text      "dana_dinner"
    t.text      "bobs_dinner"
  end

  create_table "posts", :force => true do |t|
    t.string    "title"
    t.text      "content"
    t.integer   "user_id"
    t.timestamp "created_at",                    :null => false
    t.timestamp "updated_at",                    :null => false
    t.integer   "issue_id"
    t.string    "photo_url"
    t.boolean   "anon",       :default => false
  end

  create_table "users", :force => true do |t|
    t.string    "name"
    t.string    "email"
    t.timestamp "created_at",                    :null => false
    t.timestamp "updated_at",                    :null => false
    t.boolean   "receive",    :default => true
    t.boolean   "admin",      :default => false
    t.string    "provider"
    t.string    "uid"
    t.boolean   "canpost",    :default => false
    t.integer   "karma",      :default => 0
  end

  create_table "votes", :force => true do |t|
    t.integer   "user_id"
    t.integer   "post_id"
    t.boolean   "up"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

end
