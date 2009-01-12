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

ActiveRecord::Schema.define(:version => 20090112093201) do

  create_table "address_lists", :force => true do |t|
    t.text     "addresses"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contents", :force => true do |t|
    t.integer  "parent_id"
    t.string   "type"
    t.string   "title"
    t.string   "slug"
    t.text     "body"
    t.integer  "position",                :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "footer"
    t.text     "sidebar"
    t.string   "currency"
    t.string   "donation_amounts"
    t.string   "paypal_account"
    t.string   "show_child_links_at",     :default => "top"
    t.string   "show_child_links_as",     :default => "links"
    t.string   "show_child_links_prompt"
    t.boolean  "hide_next_page",          :default => false
    t.string   "one_time_donation_title", :default => "Make a One-time Donation"
    t.text     "one_time_donation_text"
    t.string   "monthly_donation_title",  :default => "Schedule a Monthly Donation"
    t.text     "monthly_donation_text"
    t.string   "online_donation_method"
  end

  create_table "documents", :force => true do |t|
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", :force => true do |t|
    t.integer  "content_id"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "caption"
  end

  create_table "shares", :force => true do |t|
    t.integer  "content_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",            :null => false
    t.string   "crypted_password", :null => false
    t.string   "password_salt",    :null => false
    t.string   "remember_token",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
