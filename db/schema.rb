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

ActiveRecord::Schema.define(:version => 20140815165255) do

  create_table "actions", :force => true do |t|
    t.date     "due"
    t.string   "action"
    t.integer  "actionable_id"
    t.string   "actionable_type"
    t.boolean  "complete"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "actions", ["actionable_id"], :name => "index_actions_on_actionable_id"
  add_index "actions", ["actionable_type"], :name => "index_actions_on_actionable_type"
  add_index "actions", ["due"], :name => "index_actions_on_due"

  create_table "activities", :force => true do |t|
    t.integer  "user_id"
    t.date     "date_start"
    t.date     "date_end"
    t.text     "subject"
    t.string   "maker"
    t.string   "maker_medium"
    t.string   "maker_phone"
    t.string   "maker_email"
    t.string   "maker_site"
    t.string   "maker_address_street"
    t.string   "maker_address_city"
    t.string   "maker_address_state"
    t.string   "maker_address_zipcode"
    t.boolean  "include_image",         :default => false
    t.boolean  "include_title",         :default => false
    t.boolean  "include_inventory_id",  :default => false
    t.boolean  "include_creation_date", :default => false
    t.boolean  "include_quantity",      :default => false
    t.boolean  "include_dimensions",    :default => false
    t.boolean  "include_materials",     :default => false
    t.boolean  "include_description",   :default => false
    t.boolean  "include_income",        :default => false
    t.boolean  "include_retail",        :default => false
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.integer  "client_id"
    t.integer  "venue_id"
    t.integer  "category_id"
  end

  add_index "activities", ["user_id"], :name => "index_activities_on_user_id"

  create_table "activityworks", :force => true do |t|
    t.integer  "activity_id"
    t.integer  "work_id"
    t.decimal  "income"
    t.decimal  "retail"
    t.integer  "sold"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "quantity"
  end

  add_index "activityworks", ["activity_id"], :name => "index_activityworks_on_activity_id"
  add_index "activityworks", ["work_id"], :name => "index_activityworks_on_work_id"

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.string   "munged_name"
    t.string   "email"
    t.string   "phone"
    t.string   "address_street"
    t.string   "address_city"
    t.string   "address_state"
    t.integer  "address_zipcode"
    t.integer  "user_id"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "site"
    t.boolean  "share",           :default => false
  end

  add_index "clients", ["munged_name"], :name => "index_clients_on_munged_name"
  add_index "clients", ["name"], :name => "index_clients_on_name"

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "type_id"
    t.string   "name"
    t.date     "date"
    t.string   "comment",    :limit => 2000
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "notes", :force => true do |t|
    t.date     "date"
    t.string   "note"
    t.integer  "notable_id"
    t.string   "notable_type"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "notes", ["notable_id"], :name => "index_notes_on_notable_id"
  add_index "notes", ["notable_type"], :name => "index_notes_on_notable_type"

  create_table "payment_notifications", :force => true do |t|
    t.text     "params"
    t.integer  "user_id"
    t.string   "status"
    t.string   "transaction_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "item"
  end

  create_table "users", :force => true do |t|
    t.boolean  "admin",                   :default => false
    t.boolean  "share_with_makers",       :default => false
    t.boolean  "share_with_public",       :default => false
    t.boolean  "share_about",             :default => false
    t.boolean  "share_contact",           :default => false
    t.boolean  "share_works_price",       :default => false
    t.boolean  "share_purchase",          :default => false
    t.boolean  "share_works",             :default => false
    t.string   "username"
    t.string   "password_digest"
    t.string   "remember_token"
    t.string   "name"
    t.string   "domain"
    t.string   "tag_line"
    t.string   "blog"
    t.string   "email"
    t.string   "phone"
    t.string   "address_street"
    t.string   "address_city"
    t.string   "address_state"
    t.string   "address_zipcode"
    t.string   "social_etsy"
    t.string   "social_googleplus"
    t.string   "social_facebook"
    t.string   "social_linkedin"
    t.string   "social_twitter"
    t.string   "social_pinterest"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "tier"
    t.boolean  "share_works_status",      :default => true
    t.boolean  "share_works_materials",   :default => true
    t.boolean  "share_works_dimensions",  :default => true
    t.boolean  "share_works_description", :default => true
    t.integer  "bio_id"
    t.integer  "statement_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

  create_table "venues", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "munged_name"
    t.string   "phone"
    t.string   "address_street"
    t.string   "address_city"
    t.string   "address_state"
    t.string   "address_zipcode"
    t.string   "email"
    t.string   "site"
    t.boolean  "share",           :default => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "venues", ["name"], :name => "index_venues_on_name"
  add_index "venues", ["user_id"], :name => "index_venues_on_user_id"

  create_table "workcategories", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "artist_statement", :limit => 1000
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workcategories", ["name"], :name => "index_workcategories_on_name"
  add_index "workcategories", ["parent_id"], :name => "index_workcategories_on_parent_id"
  add_index "workcategories", ["user_id"], :name => "index_workcategories_on_user_id"

  create_table "works", :force => true do |t|
    t.integer  "user_id"
    t.integer  "workcategory_id"
    t.string   "inventory_id"
    t.string   "title"
    t.date     "creation_date"
    t.decimal  "expense_hours"
    t.decimal  "expense_materials"
    t.decimal  "income"
    t.decimal  "retail"
    t.string   "description"
    t.boolean  "share",               :default => false
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "image1_file_name"
    t.string   "image1_content_type"
    t.integer  "image1_file_size"
    t.datetime "image1_updated_at"
    t.string   "materials"
    t.integer  "quantity",            :default => 1
    t.string   "dimensions"
  end

  add_index "works", ["inventory_id"], :name => "index_works_on_inventory_id"
  add_index "works", ["title"], :name => "index_works_on_title"
  add_index "works", ["user_id"], :name => "index_works_on_user_id"
  add_index "works", ["workcategory_id"], :name => "index_works_on_workcategory_id"

end
