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

ActiveRecord::Schema.define(version: 20170321081556) do

  create_table "account_inboxes", force: true do |t|
    t.integer  "account_id"
    t.integer  "inbox_id"
    t.boolean  "is_read",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "account_inboxes", ["account_id"], name: "index_account_inboxes_on_account_id", using: :btree
  add_index "account_inboxes", ["inbox_id"], name: "index_account_inboxes_on_inbox_id", using: :btree

  create_table "account_omniauths", force: true do |t|
    t.integer  "account_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
    t.datetime "expires_at"
  end

  add_index "account_omniauths", ["account_id"], name: "index_account_omniauths_on_account_id", using: :btree

  create_table "accounts", force: true do |t|
    t.string   "email",                             default: "",    null: false
    t.string   "encrypted_password",                default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "avatar_url"
    t.string   "first_phone",            limit: 20
    t.string   "last_phone",             limit: 20
    t.string   "image"
    t.string   "api_key"
    t.string   "office_token"
    t.string   "company"
    t.date     "birth_date"
    t.string   "sickness"
    t.string   "need_help"
    t.date     "start_time"
    t.string   "native_place"
    t.string   "edu_level"
    t.string   "home_address"
    t.boolean  "fastable",                          default: false
    t.string   "salary_level"
  end

  add_index "accounts", ["api_key"], name: "index_accounts_on_api_key", using: :btree
  add_index "accounts", ["email"], name: "index_accounts_on_email", unique: true, using: :btree
  add_index "accounts", ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true, using: :btree

  create_table "address_translators", force: true do |t|
    t.integer  "low_num"
    t.integer  "hight_num"
    t.string   "street_name", limit: 100
    t.integer  "nyc_bin"
    t.string   "borough",     limit: 30
    t.string   "city",        limit: 20
    t.string   "zipcode",     limit: 6
    t.integer  "building_id"
    t.integer  "master_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "base_num",    limit: 15
  end

  add_index "address_translators", ["building_id"], name: "index_address_translators_on_building_id", using: :btree

  create_table "agents", force: true do |t|
    t.integer  "broker_id"
    t.string   "name"
    t.string   "tel"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "origin_url"
    t.string   "s3_url"
    t.string   "sizes"
    t.text     "introduction"
    t.string   "website"
    t.string   "office_tel",   limit: 20
    t.string   "fax_tel",      limit: 20
    t.string   "mobile_tel",   limit: 20
    t.string   "address"
    t.integer  "listing_num"
    t.integer  "account_id"
  end

  add_index "agents", ["account_id"], name: "index_agents_on_account_id", using: :btree
  add_index "agents", ["broker_id"], name: "index_agents_on_broker_id", using: :btree

  create_table "blogs", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_urls", limit: 2000
  end

  create_table "book_showings", force: true do |t|
    t.integer  "date_id"
    t.integer  "slot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name",       null: false
    t.string   "email",      null: false
  end

  add_index "book_showings", ["date_id"], name: "index_book_showings_on_date_id", using: :btree
  add_index "book_showings", ["slot_id"], name: "index_book_showings_on_slot_id", using: :btree

  create_table "broker_lls_statuses", force: true do |t|
    t.string   "name"
    t.string   "active_lls"
    t.string   "added_today"
    t.string   "expired_today"
    t.string   "manhattan"
    t.string   "brooklyn"
    t.string   "queens"
    t.string   "bronx"
    t.string   "other_cities"
    t.string   "active_no_fee"
    t.string   "added_no_fee"
    t.string   "expired_no_fee"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "status_date"
    t.string   "mls_name",       limit: 30
  end

  add_index "broker_lls_statuses", ["name"], name: "index_broker_lls_statuses_on_name", using: :btree
  add_index "broker_lls_statuses", ["status_date"], name: "index_broker_lls_statuses_on_status_date", using: :btree

  create_table "brokers", force: true do |t|
    t.string   "name"
    t.string   "tel"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "listing_num"
    t.string   "street_address", limit: 100
    t.string   "state",          limit: 10
    t.string   "zipcode",        limit: 20
    t.string   "website",        limit: 50
    t.string   "client_id",      limit: 30
    t.text     "introduction"
    t.integer  "status",         limit: 1,   default: 0
  end

  add_index "brokers", ["name"], name: "index_brokers_on_name", using: :btree

  create_table "building_images", force: true do |t|
    t.string   "image"
    t.integer  "building_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "building_images", ["building_id"], name: "index_building_images_on_building_id", using: :btree

  create_table "building_listings", force: true do |t|
    t.integer  "building_id"
    t.integer  "listing_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "building_listings", ["building_id"], name: "index_building_listings_on_building_id", using: :btree
  add_index "building_listings", ["listing_id"], name: "index_building_listings_on_listing_id", using: :btree

  create_table "buildings", force: true do |t|
    t.string   "city",          limit: 20
    t.string   "borough",       limit: 20
    t.integer  "block"
    t.integer  "lot"
    t.integer  "cd"
    t.integer  "ct2010"
    t.integer  "cb2010"
    t.integer  "school_dist"
    t.integer  "councli"
    t.string   "zipcode",       limit: 5
    t.string   "fire_comp",     limit: 20
    t.integer  "police_prct"
    t.string   "address"
    t.string   "zone_dist1",    limit: 20
    t.string   "overlay1",      limit: 20
    t.string   "s_p_dist1",     limit: 20
    t.string   "all_zoning1",   limit: 20
    t.string   "allzoning",     limit: 20
    t.string   "split_zone",    limit: 20
    t.string   "bldg_class",    limit: 20
    t.integer  "land_use"
    t.integer  "easements"
    t.string   "owner_type",    limit: 5
    t.string   "owner_name"
    t.integer  "lot_area"
    t.integer  "bldg_area"
    t.integer  "com_area"
    t.integer  "res_area"
    t.integer  "office_area"
    t.integer  "retail_area"
    t.integer  "garage_area"
    t.integer  "strge_area"
    t.integer  "factry_area"
    t.integer  "other_area"
    t.integer  "area_source"
    t.integer  "num_bldgs"
    t.integer  "num_floors"
    t.integer  "units_res"
    t.integer  "units_total"
    t.integer  "lot_front"
    t.integer  "lot_depth"
    t.integer  "bldg_front"
    t.integer  "bldg_depth"
    t.string   "ext",           limit: 5
    t.integer  "prox_code"
    t.string   "irr_lot_code",  limit: 5
    t.integer  "lot_type",      limit: 2
    t.integer  "bsmt_code",     limit: 2
    t.integer  "year_built"
    t.integer  "built_code"
    t.integer  "year_alter1"
    t.integer  "year_alter2"
    t.string   "hist_dist",     limit: 50
    t.string   "land_mark"
    t.float    "built_far",     limit: 24
    t.float    "resid_far",     limit: 24
    t.float    "comm_far",      limit: 24
    t.float    "facil_far",     limit: 24
    t.float    "boro_code",     limit: 24
    t.string   "bbl",           limit: 20
    t.integer  "tract2010"
    t.integer  "condo_no"
    t.string   "sanborn",       limit: 20
    t.string   "version",       limit: 20
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "flag",          limit: 1,    default: 0
    t.string   "name",          limit: 40
    t.text     "description"
    t.string   "amenities",     limit: 2000
    t.boolean  "bflag",                      default: false, null: false
    t.text     "apt_amenities"
    t.text     "neighborhood"
  end

  add_index "buildings", ["city", "borough", "address"], name: "index_buildings_on_city_and_borough_and_address", using: :btree

  create_table "checkin_buildings", force: true do |t|
    t.string   "name",       null: false
    t.integer  "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "unit",       null: false
  end

  add_index "checkin_buildings", ["client_id"], name: "index_checkin_buildings_on_client_id", using: :btree

  create_table "cities", force: true do |t|
    t.string  "name",       limit: 30
    t.string  "state",      limit: 20
    t.string  "long_state", limit: 30
    t.string  "country",    limit: 20
    t.string  "min_zip",    limit: 7
    t.string  "max_zip",    limit: 7
    t.float   "lat",        limit: 24
    t.float   "lng",        limit: 24
    t.integer "hot"
  end

  add_index "cities", ["hot"], name: "index_cities_on_hot", using: :btree
  add_index "cities", ["name"], name: "index_cities_on_name", using: :btree
  add_index "cities", ["state"], name: "index_cities_on_state", using: :btree

  create_table "client_applies", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.date     "dob"
    t.string   "phone"
    t.string   "email"
    t.string   "ssn"
    t.string   "building"
    t.string   "unit"
    t.string   "current_addr"
    t.string   "current_landlord"
    t.string   "current_landlord_ph"
    t.integer  "current_rent"
    t.string   "position"
    t.string   "company"
    t.date     "start_date"
    t.integer  "salary"
    t.string   "pet"
    t.string   "breed"
    t.string   "pet_name"
    t.integer  "pet_age"
    t.float    "pet_weight",          limit: 24
    t.string   "emergency_name"
    t.string   "emergency_addr"
    t.string   "emergency_phone"
    t.string   "emergency_relation"
    t.string   "referral"
    t.boolean  "is_employed"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "residency"
    t.string   "access_token"
  end

  add_index "client_applies", ["access_token"], name: "index_client_applies_on_access_token", unique: true, using: :btree

  create_table "client_checkins", force: true do |t|
    t.string   "first_name",            null: false
    t.string   "last_name",             null: false
    t.string   "email",                 null: false
    t.string   "phone",      limit: 20, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "client_roommates", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "client_roommates", ["client_id"], name: "index_client_roommates_on_client_id", using: :btree

  create_table "contacts", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "subject"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "disqus", force: true do |t|
    t.string   "disqus_obj_type"
    t.integer  "disqus_obj_id"
    t.integer  "thread_id",       limit: 8
    t.integer  "post_id",         limit: 8, default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "disqus", ["disqus_obj_id"], name: "index_disqus_on_disqus_obj_id", using: :btree
  add_index "disqus", ["thread_id"], name: "index_disqus_on_thread_id", using: :btree

  create_table "documents", force: true do |t|
    t.string   "name"
    t.string   "doc_type"
    t.integer  "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "documents", ["client_id"], name: "index_documents_on_client_id", using: :btree

  create_table "floorplans", force: true do |t|
    t.string   "image"
    t.integer  "beds"
    t.float    "baths",       limit: 24
    t.integer  "price"
    t.integer  "sqft"
    t.integer  "building_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "floorplans", ["building_id"], name: "index_floorplans_on_building_id", using: :btree

  create_table "fs_categories", force: true do |t|
    t.string   "name"
    t.string   "fs_id"
    t.string   "parent_fs_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "plural_name",  limit: 100
    t.string   "short_name",   limit: 100
    t.string   "icon_prefix"
    t.string   "icon_suffix",  limit: 20
  end

  create_table "inboxes", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "list_with_us", force: true do |t|
    t.string   "identity"
    t.string   "listing_type"
    t.boolean  "sydication"
    t.string   "specify"
    t.string   "company_website"
    t.string   "listing_feed_url"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "contact_number"
  end

  create_table "listing_details", force: true do |t|
    t.integer  "listing_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "amenities",   limit: 2000
    t.integer  "maintenance",              default: 0
  end

  add_index "listing_details", ["listing_id"], name: "index_listing_details_on_listing_id", using: :btree

  create_table "listing_images", force: true do |t|
    t.integer  "listing_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "origin_url"
    t.string   "s3_url"
    t.string   "sizes"
    t.boolean  "floorplan",  default: false
  end

  add_index "listing_images", ["listing_id"], name: "index_listing_images_on_listing_id", using: :btree
  add_index "listing_images", ["origin_url"], name: "index_listing_images_on_origin_url", using: :btree

  create_table "listing_mta_lines", force: true do |t|
    t.integer  "listing_id"
    t.integer  "mta_info_line_id"
    t.integer  "listing_place_id"
    t.string   "mta_info_type",    limit: 10
    t.float    "distance",         limit: 24
    t.float    "duration",         limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "target",           limit: 20
    t.string   "distance_text",    limit: 20
    t.string   "duration_text",    limit: 20
    t.integer  "mta_info_st_id"
  end

  add_index "listing_mta_lines", ["listing_id"], name: "index_listing_mta_lines_on_listing_id", using: :btree
  add_index "listing_mta_lines", ["listing_place_id"], name: "index_listing_mta_lines_on_listing_place_id", using: :btree
  add_index "listing_mta_lines", ["mta_info_line_id"], name: "index_listing_mta_lines_on_mta_info_line_id", using: :btree

  create_table "listing_places", force: true do |t|
    t.string   "name"
    t.string   "target"
    t.float    "lat",        limit: 53
    t.float    "lng",        limit: 53
    t.integer  "listing_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "distance"
    t.integer  "duration"
  end

  add_index "listing_places", ["listing_id"], name: "index_listing_places_on_listing_id", using: :btree

  create_table "listing_providers", force: true do |t|
    t.integer  "listing_id"
    t.integer  "provider_id"
    t.string   "client_name", limit: 20
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "unit_id"
  end

  add_index "listing_providers", ["listing_id"], name: "index_listing_providers_on_listing_id", using: :btree

  create_table "listing_urls", force: true do |t|
    t.integer  "listing_id"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "listing_urls", ["listing_id"], name: "index_listing_urls_on_listing_id", using: :btree
  add_index "listing_urls", ["url"], name: "index_listing_urls_on_url", using: :btree

  create_table "listings", force: true do |t|
    t.string   "title"
    t.integer  "political_area_id"
    t.string   "unit"
    t.float    "beds",              limit: 24, default: 0.0
    t.float    "baths",             limit: 24
    t.float    "sq_ft",             limit: 24
    t.string   "listing_type"
    t.string   "contact_name"
    t.string   "contact_tel"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "zipcode"
    t.float    "lat",               limit: 53
    t.float    "lng",               limit: 53
    t.integer  "price",                        default: 0
    t.integer  "flag",              limit: 1
    t.integer  "place_flag",        limit: 1,  default: 0
    t.integer  "listing_url_id"
    t.string   "origin_url"
    t.integer  "listing_image_id"
    t.string   "image_base_url"
    t.string   "image_sizes"
    t.float    "score_transport",   limit: 24
    t.float    "score_price",       limit: 24
    t.boolean  "is_full_address",              default: true
    t.string   "formatted_address"
    t.integer  "status",            limit: 1,  default: 0
    t.integer  "display_beds",      limit: 1,  default: 0
    t.string   "broker_name"
    t.integer  "broker_id"
    t.integer  "agent_id"
    t.string   "street_address"
    t.integer  "mls_info_id"
    t.date     "date_listed"
    t.datetime "expired_date"
    t.boolean  "no_fee",                       default: false
    t.string   "raw_neighborhood",  limit: 50
    t.integer  "building_venue_id"
    t.integer  "account_id"
    t.boolean  "featured",                     default: false
    t.datetime "featured_at"
    t.datetime "featured_until"
    t.boolean  "is_flash_sale",                default: false
    t.string   "video_url"
    t.boolean  "guarantor",                    default: false
  end

  add_index "listings", ["account_id"], name: "index_listings_on_account_id", using: :btree
  add_index "listings", ["agent_id"], name: "index_listings_on_agent_id", using: :btree
  add_index "listings", ["broker_id"], name: "index_listings_on_broker_id", using: :btree
  add_index "listings", ["flag", "listing_type"], name: "index_listings_on_flag_and_listing_type", using: :btree
  add_index "listings", ["formatted_address"], name: "index_listings_on_formatted_address", using: :btree
  add_index "listings", ["is_flash_sale"], name: "index_listings_on_is_flash_sale", using: :btree
  add_index "listings", ["listing_type"], name: "index_listings_on_listing_type", using: :btree
  add_index "listings", ["origin_url"], name: "index_listings_on_origin_url", using: :btree
  add_index "listings", ["political_area_id"], name: "index_listings_on_political_area_id", using: :btree
  add_index "listings", ["zipcode"], name: "index_listings_on_zipcode", using: :btree

  create_table "mail_notifies", force: true do |t|
    t.boolean  "is_recommended", default: true
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mail_notifies", ["account_id"], name: "index_mail_notifies_on_account_id", using: :btree

  create_table "mls_infos", force: true do |t|
    t.integer  "listing_id"
    t.integer  "broker_id"
    t.integer  "mls_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "broker_name", limit: 50
    t.string   "name",        limit: 50
  end

  add_index "mls_infos", ["broker_id"], name: "index_mls_infos_on_broker_id", using: :btree
  add_index "mls_infos", ["listing_id"], name: "index_mls_infos_on_listing_id", using: :btree

  create_table "mta_info_lines", force: true do |t|
    t.string   "location"
    t.string   "name"
    t.string   "long_name"
    t.string   "icon_url"
    t.string   "mta_info_type", limit: 10
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mta_info_sts", force: true do |t|
    t.string   "name"
    t.string   "long_name"
    t.integer  "mta_info_line_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "num_name"
    t.string   "target",           limit: 20
    t.float    "lat",              limit: 53
    t.float    "lng",              limit: 53
    t.string   "borough",          limit: 50
  end

  add_index "mta_info_sts", ["mta_info_line_id"], name: "index_mta_info_sts_on_mta_info_line_id", using: :btree

  create_table "neighborhoods", force: true do |t|
    t.string   "city"
    t.string   "borough"
    t.string   "name"
    t.integer  "hot",        default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "open_houses", force: true do |t|
    t.date     "open_date"
    t.time     "begin_time"
    t.time     "end_time"
    t.integer  "listing_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "loop",                   default: false
    t.integer  "next_days",    limit: 2
    t.date     "expired_date"
  end

  add_index "open_houses", ["listing_id"], name: "index_open_houses_on_listing_id", using: :btree
  add_index "open_houses", ["open_date"], name: "index_open_houses_on_open_date", using: :btree

  create_table "owners", force: true do |t|
    t.string   "name",           null: false
    t.string   "street_address"
    t.string   "city"
    t.string   "zipcode"
    t.string   "email",          null: false
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_views", force: true do |t|
    t.string   "page_type"
    t.integer  "page_id"
    t.integer  "num",        default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
  end

  add_index "page_views", ["account_id"], name: "index_page_views_on_account_id", using: :btree
  add_index "page_views", ["page_id"], name: "index_page_views_on_page_id", using: :btree

  create_table "pages", force: true do |t|
    t.string   "name"
    t.string   "permalink"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["permalink"], name: "index_pages_on_permalink", using: :btree

  create_table "photos", force: true do |t|
    t.string   "imageable_type"
    t.integer  "imageable_id"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "review_token"
    t.boolean  "is_top"
    t.boolean  "floorplan",      default: false
    t.string   "video_url"
  end

  create_table "political_areas", force: true do |t|
    t.string   "long_name",   limit: 60
    t.string   "short_name",  limit: 60
    t.string   "target",      limit: 30
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.string   "second_name", limit: 30
    t.float    "ne_lat",      limit: 24
    t.float    "ne_lng",      limit: 24
    t.float    "sw_lat",      limit: 24
    t.float    "sw_lng",      limit: 24
    t.float    "lat",         limit: 24
    t.float    "lng",         limit: 24
    t.boolean  "enabled",                default: true
    t.string   "permalink",   limit: 60
  end

  add_index "political_areas", ["lft"], name: "index_political_areas_on_lft", using: :btree
  add_index "political_areas", ["long_name"], name: "index_political_areas_on_long_name", using: :btree
  add_index "political_areas", ["parent_id"], name: "index_political_areas_on_parent_id", using: :btree
  add_index "political_areas", ["rgt"], name: "index_political_areas_on_rgt", using: :btree
  add_index "political_areas", ["second_name"], name: "index_political_areas_on_second_name", using: :btree
  add_index "political_areas", ["short_name"], name: "index_political_areas_on_short_name", using: :btree

  create_table "reputations", force: true do |t|
    t.integer  "account_id"
    t.string   "reputable_type"
    t.integer  "reputable_id"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "review_apartments", force: true do |t|
    t.integer "review_id"
    t.integer "beds"
    t.integer "baths"
    t.float   "price",       limit: 24
    t.text    "comment"
    t.date    "lease_end"
    t.integer "convenience", limit: 1
    t.integer "living",      limit: 1
    t.integer "safety",      limit: 1
  end

  add_index "review_apartments", ["review_id"], name: "index_review_apartments_on_review_id", using: :btree

  create_table "review_places", force: true do |t|
    t.integer "review_id"
    t.string  "place_type"
    t.string  "name"
    t.text    "comment"
  end

  add_index "review_places", ["review_id"], name: "index_review_places_on_review_id", using: :btree

  create_table "review_replies", force: true do |t|
    t.integer  "account_id"
    t.integer  "review_id"
    t.integer  "parent_id"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "collect_num",  default: 0
    t.string   "display_name"
  end

  add_index "review_replies", ["account_id"], name: "index_review_replies_on_account_id", using: :btree
  add_index "review_replies", ["review_id"], name: "index_review_replies_on_review_id", using: :btree

  create_table "review_streets", force: true do |t|
    t.integer "review_id"
    t.integer "convenience"
    t.integer "living"
    t.integer "safety"
    t.text    "comment"
  end

  add_index "review_streets", ["review_id"], name: "index_review_streets_on_review_id", using: :btree

  create_table "reviews", force: true do |t|
    t.string   "address"
    t.string   "building_name"
    t.string   "city"
    t.string   "state"
    t.integer  "review_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
    t.integer  "account_id"
    t.string   "display_name"
    t.integer  "hot"
    t.string   "cross_street"
    t.integer  "collect_num"
    t.integer  "political_area_id"
    t.string   "full_address"
    t.float    "lat",               limit: 53
    t.float    "lng",               limit: 53
    t.boolean  "status",                       default: true
    t.string   "zipcode",           limit: 10
    t.integer  "ground",            limit: 1
    t.integer  "quietness",         limit: 1
    t.integer  "safety",            limit: 1
    t.integer  "convenience",       limit: 1
    t.integer  "things_to_do",      limit: 1
    t.integer  "overall_quality",   limit: 1
    t.text     "comment"
    t.integer  "building",          limit: 1
    t.integer  "management",        limit: 1
    t.boolean  "complete"
    t.integer  "venue_id"
    t.string   "unit"
    t.string   "ip",                limit: 16
  end

  add_index "reviews", ["hot"], name: "index_reviews_on_hot", using: :btree
  add_index "reviews", ["venue_id"], name: "index_reviews_on_venue_id", using: :btree

  create_table "room_details", force: true do |t|
    t.integer  "room_id",      null: false
    t.string   "amenities"
    t.text     "description"
    t.string   "pets_allowed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roommates", force: true do |t|
    t.integer  "account_id",                   null: false
    t.string   "gender"
    t.integer  "budget"
    t.string   "pets_allowed"
    t.text     "about_me"
    t.boolean  "students_only"
    t.string   "raw_neighborhood"
    t.string   "borough"
    t.string   "title",                        null: false
    t.integer  "num_roommates"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "move_in_date"
    t.integer  "duration"
    t.integer  "status",           default: 0
    t.integer  "contacted",        default: 0
  end

  create_table "rooms", force: true do |t|
    t.integer  "account_id"
    t.string   "room_type"
    t.string   "title",                                     null: false
    t.string   "street_address"
    t.string   "city"
    t.string   "zipcode"
    t.integer  "bedrooms"
    t.integer  "bathrooms"
    t.date     "available_begin_at"
    t.date     "available_end_at"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "political_area_id"
    t.float    "lat",                limit: 24
    t.float    "lng",                limit: 24
    t.string   "formatted_address"
    t.integer  "price_month"
    t.integer  "status",                        default: 0
    t.integer  "contacted",                     default: 0
    t.integer  "rooms_available",               default: 1
  end

  create_table "search_for_mes", force: true do |t|
    t.string   "name"
    t.string   "boroughs"
    t.integer  "beds"
    t.float    "baths",          limit: 24
    t.integer  "budget"
    t.date     "move_in_date"
    t.boolean  "is_employed"
    t.string   "transportation"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "referral"
    t.string   "wechat"
    t.string   "gender"
    t.string   "prefgender"
    t.integer  "minbudget"
    t.integer  "maxbudget"
    t.integer  "priority"
  end

  create_table "search_records", force: true do |t|
    t.string   "title",                   limit: 150
    t.string   "current_area",            limit: 40
    t.string   "beds"
    t.string   "baths"
    t.integer  "political_results_count"
    t.integer  "results_count"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "flag"
    t.boolean  "page_turning",                        default: false
    t.string   "session_id",              limit: 50
    t.integer  "re_search_num",                       default: 1
    t.integer  "min_price"
    t.integer  "max_price"
  end

  add_index "search_records", ["title"], name: "index_search_records_on_title", using: :btree

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "showing_dates", force: true do |t|
    t.date "date", null: false
  end

  create_table "showing_time_slots", force: true do |t|
    t.string "start_time", null: false
    t.string "end_time",   null: false
  end

  create_table "tags", force: true do |t|
    t.string   "name",       limit: 50
    t.string   "remark"
    t.text     "polygon"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transport_distances", force: true do |t|
    t.integer  "listing_id"
    t.integer  "transport_place_id"
    t.integer  "duration"
    t.integer  "distance"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "mode",               limit: 20
    t.integer  "cal_duration"
  end

  add_index "transport_distances", ["listing_id"], name: "index_transport_distances_on_listing_id", using: :btree
  add_index "transport_distances", ["transport_place_id"], name: "index_transport_distances_on_transport_place_id", using: :btree

  create_table "transport_places", force: true do |t|
    t.string   "name"
    t.string   "place_type"
    t.float    "lat",               limit: 53
    t.float    "lng",               limit: 53
    t.integer  "political_area_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "formatted_address"
  end

  add_index "transport_places", ["political_area_id"], name: "index_transport_places_on_political_area_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "venues", force: true do |t|
    t.integer  "political_area_id"
    t.string   "region_type"
    t.integer  "region_id"
    t.float    "building",          limit: 24
    t.float    "management",        limit: 24
    t.float    "convenience",       limit: 24
    t.float    "things_to_do",      limit: 24
    t.float    "safety",            limit: 24
    t.float    "ground",            limit: 24
    t.float    "quietness",         limit: 24
    t.float    "lat",               limit: 24
    t.float    "lng",               limit: 24
    t.string   "formatted_address"
    t.string   "permalink"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "overall_quality",   limit: 24
    t.integer  "reviews_count",                default: 1
    t.integer  "parent_id"
    t.boolean  "only_venue_flag",              default: false
  end

  add_index "venues", ["political_area_id"], name: "index_venues_on_political_area_id", using: :btree

  create_table "worker_applies", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.date     "dob"
    t.string   "phone"
    t.string   "email"
    t.string   "edu_level"
    t.string   "nav_place"
    t.string   "home_address"
    t.date     "start_date"
    t.integer  "salary_quest"
    t.string   "sicknesses"
    t.string   "helps"
    t.boolean  "activate"
    t.boolean  "ltservice"
    t.boolean  "qhservice"
    t.date     "available_from"
    t.date     "available_to"
    t.time     "begin_time"
    t.time     "end_time"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "access_token"
  end

  add_index "worker_applies", ["access_token"], name: "index_worker_applies_on_access_token", unique: true, using: :btree

  create_table "worker_files", force: true do |t|
    t.string   "name"
    t.string   "doc_type"
    t.integer  "worker_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "worker_files", ["worker_id"], name: "index_worker_files_on_worker_id", using: :btree

  create_table "zipcode_areas", force: true do |t|
    t.string   "zipcode"
    t.string   "political_area_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "zipcode_areas", ["political_area_name"], name: "index_zipcode_areas_on_political_area_name", using: :btree

end
