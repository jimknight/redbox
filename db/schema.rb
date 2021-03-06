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

ActiveRecord::Schema.define(version: 20140104172026) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "products", force: true do |t|
    t.string   "title"
    t.text     "synopsis"
    t.string   "genre"
    t.string   "rated"
    t.text     "actors"
    t.text     "directors"
    t.string   "release_year"
    t.text     "critics_rating"
    t.integer  "critics_score"
    t.text     "audience_rating"
    t.integer  "audience_score"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "product_id"
    t.string   "store_id"
    t.string   "store_name"
    t.string   "store_address"
    t.string   "image_url"
    t.string   "image"
  end

  create_table "products_stores", force: true do |t|
    t.integer "product_id"
    t.integer "store_id"
  end

  create_table "stores", force: true do |t|
    t.string   "store_id"
    t.string   "store_name"
    t.string   "store_address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
