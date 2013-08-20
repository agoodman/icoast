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

ActiveRecord::Schema.define(:version => 20130819212332) do

  create_table "annotations", :force => true do |t|
    t.integer   "image_id"
    t.integer   "tag_id"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
    t.integer   "user_id"
  end

  add_index "annotations", ["image_id", "tag_id", "user_id"], :name => "index_annotations_on_image_id_and_tag_id_and_user_id"
  add_index "annotations", ["image_id", "tag_id"], :name => "index_annotations_on_image_id_and_tag_id"
  add_index "annotations", ["image_id", "user_id"], :name => "index_annotations_on_image_id_and_user_id"
  add_index "annotations", ["image_id"], :name => "index_annotations_on_image_id"
  add_index "annotations", ["tag_id", "user_id"], :name => "index_annotations_on_tag_id_and_user_id"
  add_index "annotations", ["tag_id"], :name => "index_annotations_on_tag_id"
  add_index "annotations", ["user_id"], :name => "index_annotations_on_user_id"

  create_table "comments", :force => true do |t|
    t.integer   "image_id"
    t.integer   "user_id"
    t.text      "body"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  add_index "comments", ["image_id", "user_id"], :name => "index_comments_on_image_id_and_user_id"
  add_index "comments", ["image_id"], :name => "index_comments_on_image_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "groups", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  create_table "images", :force => true do |t|
    t.string    "filename"
    t.float     "latitude"
    t.float     "longitude"
    t.timestamp "taken_at"
    t.string    "full_url"
    t.string    "thumb_url"
    t.boolean   "pre"
    t.string    "storm"
    t.string    "geo_area"
    t.timestamp "created_at",  :null => false
    t.timestamp "updated_at",  :null => false
    t.integer   "position"
    t.boolean   "enabled"
    t.string    "locality"
    t.string    "city"
    t.string    "state"
    t.timestamp "geocoded_at"
    t.float     "normal_x"
    t.float     "normal_y"
  end

  add_index "images", ["position"], :name => "index_images_on_position"

  create_table "matches", :force => true do |t|
    t.integer   "user_id"
    t.integer   "post_image_id"
    t.integer   "pre_image_id"
    t.timestamp "created_at",    :null => false
    t.timestamp "updated_at",    :null => false
  end

  add_index "matches", ["pre_image_id", "post_image_id", "user_id"], :name => "index_matches_on_pre_image_id_and_post_image_id_and_user_id"
  add_index "matches", ["pre_image_id", "post_image_id"], :name => "index_matches_on_pre_image_id_and_post_image_id"

  create_table "tags", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
    t.boolean   "regime"
    t.integer   "user_id"
    t.integer   "group_id"
  end

  add_index "tags", ["group_id"], :name => "index_tags_on_group_id"
  add_index "tags", ["user_id"], :name => "index_tags_on_user_id"

  create_table "users", :force => true do |t|
    t.string    "email",                                 :null => false
    t.string    "encrypted_password",                    :null => false
    t.string    "reset_password_token"
    t.timestamp "reset_password_sent_at"
    t.timestamp "remember_created_at"
    t.integer   "sign_in_count",          :default => 0
    t.timestamp "current_sign_in_at"
    t.timestamp "last_sign_in_at"
    t.string    "current_sign_in_ip"
    t.string    "last_sign_in_ip"
    t.timestamp "created_at",                            :null => false
    t.timestamp "updated_at",                            :null => false
    t.string    "crowd_type"
    t.string    "affiliation"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "visits", :force => true do |t|
    t.integer  "user_id"
    t.integer  "image_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
