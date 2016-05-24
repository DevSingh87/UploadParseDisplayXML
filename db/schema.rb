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

ActiveRecord::Schema.define(version: 20160523055614) do

  create_table "facilities", force: true do |t|
    t.integer  "geo_id"
    t.string   "site_name"
    t.text     "address"
    t.string   "locality_name"
    t.string   "state_code"
    t.string   "zip_code"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "facilities", ["geo_id"], name: "index_facilities_on_geo_id"

  create_table "geos", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tracker_file_name"
    t.string   "tracker_content_type"
    t.integer  "tracker_file_size"
    t.datetime "tracker_updated_at"
  end

end
