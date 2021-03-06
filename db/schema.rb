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

ActiveRecord::Schema.define(version: 20180420014859) do

  create_table "airticles", force: :cascade do |t|
    t.string "title"
    t.string "prefecture"
    t.string "city"
    t.string "station"
    t.integer "price"
    t.text "scenes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "answers", force: :cascade do |t|
    t.integer "kind"
    t.string "sex"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "question_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.string "prefecture"
    t.string "city"
    t.string "station"
    t.text "scenes"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo_file_name"
    t.string "photo_content_type"
    t.integer "photo_file_size"
    t.datetime "photo_updated_at"
    t.text "content"
    t.integer "timezone"
    t.integer "number"
    t.integer "user_id"
    t.integer "clips_count"
    t.index ["user_id"], name: "index_articles_on_user_id"
  end

  create_table "clips", force: :cascade do |t|
    t.string "sex"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "article_id"
    t.index ["article_id"], name: "index_clips_on_article_id"
    t.index ["user_id"], name: "index_clips_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.string "sex"
    t.integer "user_id"
    t.integer "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_comments_on_question_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "copies", force: :cascade do |t|
    t.integer "user_id"
    t.integer "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_copies_on_course_id"
    t.index ["user_id"], name: "index_copies_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.integer "user_id"
    t.integer "spot1_id"
    t.integer "spot2_id"
    t.integer "spot3_id"
    t.integer "spot4_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.boolean "release", default: false, null: false
    t.integer "price_used"
    t.text "good_point"
    t.text "bad_point"
    t.string "went"
    t.string "city"
    t.string "timezone"
    t.text "description"
    t.string "time_start"
    t.string "time_end"
    t.string "type"
    t.string "kind"
    t.index ["user_id"], name: "index_courses_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.integer "kind"
    t.integer "user_id"
    t.integer "spot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sex"
    t.index ["spot_id"], name: "index_likes_on_spot_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "loves", force: :cascade do |t|
    t.integer "user_id"
    t.integer "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_loves_on_course_id"
    t.index ["user_id"], name: "index_loves_on_user_id"
  end

  create_table "pictures", force: :cascade do |t|
    t.integer "spot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.integer "user_id"
    t.string "quote"
    t.string "url"
    t.integer "course_id"
    t.index ["course_id"], name: "index_pictures_on_course_id"
    t.index ["spot_id"], name: "index_pictures_on_spot_id"
    t.index ["user_id"], name: "index_pictures_on_user_id"
  end

  create_table "points", force: :cascade do |t|
    t.integer "spot_id"
    t.integer "course_id"
    t.string "memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "number"
    t.index ["course_id"], name: "index_points_on_course_id"
    t.index ["spot_id"], name: "index_points_on_spot_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "category"
    t.text "content"
    t.string "sex"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo_file_name"
    t.string "photo_content_type"
    t.integer "photo_file_size"
    t.datetime "photo_updated_at"
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "snaps", force: :cascade do |t|
    t.integer "article_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.index ["article_id"], name: "index_snaps_on_article_id"
    t.index ["user_id"], name: "index_snaps_on_user_id"
  end

  create_table "spots", force: :cascade do |t|
    t.string "title"
    t.string "prefecture"
    t.string "city"
    t.text "scenes"
    t.string "price"
    t.text "description"
    t.string "introduction"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo_file_name"
    t.string "photo_content_type"
    t.integer "photo_file_size"
    t.datetime "photo_updated_at"
    t.string "station"
    t.string "address"
    t.integer "likes_count"
    t.integer "article_id"
    t.string "retty"
    t.string "browser"
    t.string "phone"
    t.string "large"
    t.string "small"
    t.text "heading"
    t.string "tabelog"
    t.text "point1"
    t.text "point2"
    t.text "point3"
    t.float "latitude"
    t.float "longitude"
    t.integer "price_dinner"
    t.integer "price_lunch"
    t.string "monday"
    t.string "tuesday"
    t.string "wednesday"
    t.string "thursday"
    t.string "friday"
    t.string "saturday"
    t.string "sunday"
    t.string "holiday"
    t.string "access"
    t.string "service"
    t.string "charge"
    t.string "smoking"
    t.string "payment"
    t.integer "price_spot"
    t.string "timezone"
    t.index ["user_id"], name: "index_spots_on_user_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "timelines", force: :cascade do |t|
    t.integer "course_id"
    t.string "city_dinner"
    t.integer "price_dinner"
    t.string "small_dinner"
    t.string "city_lunch"
    t.integer "price_lunch"
    t.string "small_lunch"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_timelines_on_course_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "image"
    t.string "name"
    t.string "nickname"
    t.string "sex"
    t.integer "age"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.string "authority"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
