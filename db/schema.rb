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

ActiveRecord::Schema.define(:version => 20120725092249) do

  create_table "companies", :force => true do |t|
    t.string  "name",              :limit => 100, :default => "", :null => false
    t.string  "address",           :limit => 200
    t.string  "phone",             :limit => 50
    t.string  "fax",               :limit => 50
    t.string  "logo_file_name",    :limit => 100
    t.string  "logo_content_type"
    t.integer "logo_file_size"
    t.string  "gst_number"
    t.string  "pst_number"
  end

  create_table "companies_users", :id => false, :force => true do |t|
    t.integer "company_id"
    t.integer "user_id"
  end

  create_table "customers", :force => true do |t|
    t.string   "name",       :limit => 150, :null => false
    t.string   "address",    :limit => 200
    t.string   "phone",      :limit => 50
    t.string   "fax",        :limit => 50
    t.string   "email",      :limit => 50
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "database_translation_fields", :force => true do |t|
    t.string "table",                  :limit => 50, :default => "", :null => false
    t.string "translation_field_name", :limit => 50, :default => "", :null => false
  end

  create_table "database_translations", :force => true do |t|
    t.integer "record_id",                            :default => 0,  :null => false
    t.string  "table",                  :limit => 50, :default => "", :null => false
    t.string  "translation_field_name", :limit => 50, :default => "", :null => false
    t.text    "fr"
    t.text    "en"
    t.text    "es"
  end

  create_table "dimensions", :force => true do |t|
    t.integer "serie_id",              :default => 0,   :null => false
    t.float   "value",                 :default => 0.0, :null => false
    t.string  "type",     :limit => 6, :default => "",  :null => false
  end

  create_table "door_borings", :force => true do |t|
    t.string   "name"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "price",              :default => 0.0
  end

  create_table "door_combinations", :force => true do |t|
    t.string   "name"
    t.string   "sections"
    t.string   "preview_image_name"
    t.integer  "door_frame_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "price",              :default => 0.0
  end

  create_table "door_combinations_door_openings", :id => false, :force => true do |t|
    t.integer "door_combination_id"
    t.integer "door_opening_id"
  end

  create_table "door_frames", :force => true do |t|
    t.string   "name"
    t.integer  "sections"
    t.string   "preview_image_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "price",              :default => 0.0
  end

  create_table "door_glass_families", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "door_glasses", :force => true do |t|
    t.string   "name"
    t.integer  "door_glass_family_id"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "price",                :default => 0.0
  end

  create_table "door_glasses_door_panels", :id => false, :force => true do |t|
    t.integer "door_glass_id"
    t.integer "door_panel_id"
  end

  create_table "door_line_options", :force => true do |t|
    t.integer  "door_line_id"
    t.integer  "option_id"
    t.float    "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "door_line_sections", :force => true do |t|
    t.integer  "door_line_id"
    t.integer  "sort_order"
    t.integer  "door_section_id"
    t.integer  "door_panel_id"
    t.integer  "door_glass_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "door_panel_dimension_id"
  end

  create_table "door_lines", :force => true do |t|
    t.integer  "quotation_id"
    t.integer  "door_frame_id"
    t.integer  "quantity"
    t.float    "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "door_combination_id"
    t.integer  "frame_profile_id"
    t.integer  "slab_material_id"
    t.integer  "door_opening_id"
    t.integer  "door_boring_id"
    t.string   "exterior_color"
    t.string   "interior_color"
    t.integer  "standard_interior_color_id"
    t.integer  "standard_exterior_color_id"
  end

  create_table "door_openings", :force => true do |t|
    t.string   "name"
    t.string   "preview_image_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "price",              :default => 0.0
  end

  create_table "door_panel_dimensions", :force => true do |t|
    t.integer  "door_panel_id"
    t.float    "width"
    t.float    "height"
    t.float    "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "door_panel_families", :force => true do |t|
    t.string   "name"
    t.integer  "slab_material_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "door_panels", :force => true do |t|
    t.string   "name"
    t.string   "preview_image_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "price",                :default => 0.0
    t.integer  "door_panel_family_id"
  end

  create_table "door_panels_door_sections", :id => false, :force => true do |t|
    t.integer "door_panel_id"
    t.integer "door_section_id"
  end

  create_table "door_sections", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "price",      :default => 0.0
  end

  create_table "emails", :force => true do |t|
    t.string   "subject"
    t.text     "body"
    t.boolean  "sent"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "frame_profiles", :force => true do |t|
    t.string   "name"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "price",              :default => 0.0
    t.float    "width",              :default => 0.0
    t.float    "separator_width",    :default => 0.0
    t.float    "gap",                :default => 0.0
  end

  create_table "module_types", :force => true do |t|
    t.string   "name"
    t.string   "gender"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "module_types_users", :id => false, :force => true do |t|
    t.integer "module_type_id"
    t.integer "user_id"
  end

  create_table "openings", :force => true do |t|
    t.string  "name",               :limit => 50,  :default => "",    :null => false
    t.string  "abbreviation",       :limit => 5,   :default => "",    :null => false
    t.boolean "openable",                          :default => false, :null => false
    t.string  "preview_image_name", :limit => 100
    t.integer "glasses_quantity",                  :default => 1,     :null => false
  end

  create_table "openings_series", :id => false, :force => true do |t|
    t.integer "opening_id", :default => 0, :null => false
    t.integer "serie_id",   :default => 0, :null => false
  end

  create_table "option_categories", :force => true do |t|
    t.string  "name"
    t.string  "description"
    t.integer "display_order"
    t.boolean "multiselect"
  end

  create_table "option_categories_options", :id => false, :force => true do |t|
    t.integer "option_category_id"
    t.integer "option_id"
  end

  create_table "options", :force => true do |t|
    t.string  "description",             :limit => 50, :default => "",  :null => false
    t.text    "comments"
    t.integer "pricing_method_id",                     :default => 0,   :null => false
    t.float   "price",                                 :default => 0.0, :null => false
    t.float   "minimum_quantity",                      :default => 0.0, :null => false
    t.integer "options_minimum_unit_id",               :default => 1,   :null => false
    t.string  "photo_file_name"
    t.string  "photo_content_type"
    t.integer "photo_file_size"
    t.integer "module_type_id",                        :default => 1
    t.integer "apply_to",                              :default => 0,   :null => false
  end

  create_table "options_minimum_units", :force => true do |t|
    t.string "description", :limit => 50, :default => "", :null => false
    t.text   "comments"
  end

  create_table "options_quotation_lines", :force => true do |t|
    t.integer "option_id",         :default => 0, :null => false
    t.integer "quotation_line_id", :default => 0, :null => false
    t.integer "quantity",          :default => 1, :null => false
  end

  create_table "options_quotations", :force => true do |t|
    t.integer "option_id",    :default => 0,   :null => false
    t.integer "quotation_id", :default => 0,   :null => false
    t.float   "quantity",     :default => 1.0, :null => false
  end

  create_table "options_series", :id => false, :force => true do |t|
    t.integer "option_id", :default => 0, :null => false
    t.integer "serie_id",  :default => 0, :null => false
  end

  create_table "permissions", :force => true do |t|
    t.integer  "role_id",    :default => 0, :null => false
    t.integer  "user_id",    :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "preview_images", :force => true do |t|
    t.integer "opening_id",                              :null => false
    t.string  "hinged_on",  :limit => 1, :default => "", :null => false
    t.string  "image_name"
  end

  create_table "pricing_methods", :force => true do |t|
    t.string  "description",  :limit => 50, :default => "",    :null => false
    t.text    "comments"
    t.boolean "quantifiable",               :default => false
  end

  create_table "product_colors", :force => true do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "module_type_id", :default => 1
  end

  create_table "quotation_lines", :force => true do |t|
    t.integer "quotation_id",               :default => 0,   :null => false
    t.integer "serie_id",                   :default => 0,   :null => false
    t.integer "shape_id",                   :default => 0,   :null => false
    t.float   "width",                      :default => 0.0, :null => false
    t.float   "height",                     :default => 0.0, :null => false
    t.integer "quantity",                   :default => 0,   :null => false
    t.float   "price",                      :default => 0.0, :null => false
    t.string  "label"
    t.string  "exterior_color"
    t.string  "interior_color"
    t.integer "standard_interior_color_id"
    t.integer "standard_exterior_color_id"
  end

  create_table "quotation_lines_openings", :force => true do |t|
    t.integer "quotation_line_id", :default => 0, :null => false
    t.integer "opening_id",        :default => 0, :null => false
    t.integer "sort_order",        :default => 0, :null => false
  end

  create_table "quotations", :force => true do |t|
    t.string   "description",      :limit => 50,  :default => "",    :null => false
    t.text     "comments"
    t.string   "project_name",     :limit => 150
    t.string   "customer_name",    :limit => 150
    t.string   "customer_address", :limit => 200
    t.string   "customer_phone",   :limit => 50
    t.string   "customer_fax",     :limit => 50
    t.string   "customer_email",   :limit => 50
    t.float    "transport",                       :default => 0.0,   :null => false
    t.float    "discount",                        :default => 0.0,   :null => false
    t.float    "taxes",                           :default => 0.0,   :null => false
    t.text     "notes"
    t.boolean  "ready_to_sign",                   :default => false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "delivery_address"
    t.integer  "company_id"
    t.float    "markup",                          :default => 0.0,   :null => false
    t.string   "consultant"
    t.float    "deposit"
    t.float    "taxes_pst"
    t.string   "slug"
  end

  add_index "quotations", ["slug"], :name => "quotations_slug_index", :unique => true

  create_table "roles", :force => true do |t|
    t.string "rolename"
  end

  create_table "section_dimensions", :force => true do |t|
    t.integer "quotation_line_id",               :default => 0,   :null => false
    t.integer "sort_order",                      :default => 0,   :null => false
    t.float   "value",                           :default => 0.0, :null => false
    t.string  "type",              :limit => 13, :default => "",  :null => false
  end

  create_table "serie_prices", :force => true do |t|
    t.integer "width_id",   :default => 0,   :null => false
    t.integer "height_id",  :default => 0,   :null => false
    t.integer "opening_id", :default => 0,   :null => false
    t.float   "price",      :default => 0.0, :null => false
  end

  create_table "series", :force => true do |t|
    t.string "name",        :limit => 50,  :default => "", :null => false
    t.string "description",                :default => "", :null => false
    t.text   "comments"
    t.text   "series_type", :limit => 255
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id"
    t.text     "data"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "shapes", :force => true do |t|
    t.string  "name",                :limit => 50, :default => "",    :null => false
    t.integer "sections_width",                    :default => 0,     :null => false
    t.integer "sections_height",                   :default => 0,     :null => false
    t.integer "corners",                           :default => 4,     :null => false
    t.boolean "has_upper_transom",                 :default => false
    t.boolean "has_lower_transom",                 :default => false
    t.boolean "has_left_sidelight",                :default => false
    t.boolean "has_right_sidelight",               :default => false
  end

  create_table "slab_materials", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "price",      :default => 0.0
  end

  create_table "translations", :force => true do |t|
    t.string "translation_key", :limit => 100, :default => "", :null => false
    t.text   "fr"
    t.text   "comments"
    t.text   "en"
    t.text   "es"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "password_reset_code",       :limit => 40
    t.boolean  "enabled",                                 :default => true
    t.float    "discount",                                :default => 0.0,  :null => false
  end

end
