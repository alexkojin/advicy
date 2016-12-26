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

ActiveRecord::Schema.define(version: 20161226081009) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "actor_id"
    t.string   "actor_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at",     null: false
    t.index ["actor_type", "actor_id"], name: "index_activities_on_actor_type_and_actor_id", using: :btree
    t.index ["recipient_type", "recipient_id"], name: "index_activities_on_recipient_type_and_recipient_id", using: :btree
    t.index ["trackable_type", "trackable_id"], name: "index_activities_on_trackable_type_and_trackable_id", using: :btree
  end

  create_table "answers", force: :cascade do |t|
    t.integer  "question_id",                 null: false
    t.integer  "answerer_id",                 null: false
    t.boolean  "best",        default: false
    t.text     "body",                        null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "score",       default: 0,     null: false
    t.text     "body_html"
    t.index ["answerer_id"], name: "index_answers_on_answerer_id", using: :btree
    t.index ["question_id"], name: "index_answers_on_question_id", using: :btree
  end

  create_table "badges", force: :cascade do |t|
    t.integer  "value",       null: false
    t.string   "title",       null: false
    t.text     "description", null: false
    t.string   "image_url"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "slug",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name", unique: true, using: :btree
    t.index ["slug"], name: "index_categories_on_slug", unique: true, using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "commenter_id"
    t.string   "body"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id", using: :btree
    t.index ["commenter_id"], name: "index_comments_on_commenter_id", using: :btree
  end

  create_table "companies", force: :cascade do |t|
    t.integer  "owner_id",                          null: false
    t.string   "name",                              null: false
    t.string   "role",         default: "employee", null: false
    t.string   "logo"
    t.string   "website",                           null: false
    t.string   "location",                          null: false
    t.string   "markets",                           null: false
    t.string   "size",         default: "1-10",     null: false
    t.string   "pitch",                             null: false
    t.text     "preface"
    t.text     "product_info"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.index ["owner_id", "name"], name: "index_companies_on_owner_id_and_name", unique: true, using: :btree
    t.index ["owner_id"], name: "index_companies_on_owner_id", using: :btree
  end

  create_table "connections", force: :cascade do |t|
    t.integer  "company_id",                                null: false
    t.string   "role",                                      null: false
    t.integer  "member_id"
    t.string   "member_type"
    t.decimal  "investment_amount", precision: 8, scale: 2
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.index ["company_id", "role", "member_type", "member_id"], name: "index_connections", unique: true, using: :btree
  end

  create_table "educations", force: :cascade do |t|
    t.integer  "job_id",                 null: false
    t.string   "kind",                   null: false
    t.integer  "importance", default: 2, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["job_id", "kind"], name: "index_educations_on_job_id_and_kind", unique: true, using: :btree
  end

  create_table "flags", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "flaggable_id"
    t.string   "flaggable_type"
    t.string   "flag_type"
    t.text     "reason"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["flaggable_id", "flaggable_type"], name: "index_flags_on_flaggable_id_and_flaggable_type", using: :btree
    t.index ["user_id", "flaggable_id", "flaggable_type"], name: "index_flags_on_user_id_and_flaggable_id_and_flaggable_type", using: :btree
  end

  create_table "old_users", force: :cascade do |t|
    t.string   "email",           null: false
    t.string   "username",        null: false
    t.string   "image_url"
    t.string   "password_digest", null: false
    t.string   "session_token",   null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "uid"
    t.string   "provider"
    t.index ["email"], name: "index_old_users_on_email", using: :btree
    t.index ["session_token"], name: "index_old_users_on_session_token", using: :btree
    t.index ["username"], name: "index_old_users_on_username", using: :btree
  end

  create_table "questions", force: :cascade do |t|
    t.integer  "asker_id",                     null: false
    t.string   "title",                        null: false
    t.text     "description"
    t.integer  "views_count",      default: 0, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "category_id",                  null: false
    t.integer  "score",            default: 0, null: false
    t.text     "description_html"
    t.integer  "answers_count",    default: 0, null: false
    t.index ["answers_count", "created_at"], name: "index_questions_on_answers_count_and_created_at", using: :btree
    t.index ["asker_id"], name: "index_questions_on_asker_id", using: :btree
    t.index ["title"], name: "index_questions_on_title", using: :btree
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "name"
    t.string   "image_url"
    t.string   "uid",                    default: "",      null: false
    t.string   "provider",               default: "email", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "views", force: :cascade do |t|
    t.integer  "viewable_id"
    t.string   "viewable_type"
    t.integer  "user_id"
    t.string   "ip"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["viewable_id", "viewable_type", "ip"], name: "index_views_on_viewable_id_and_viewable_type_and_ip", using: :btree
    t.index ["viewable_id", "viewable_type", "user_id"], name: "index_views_on_viewable_id_and_viewable_type_and_user_id", using: :btree
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "voter_id"
    t.integer  "value"
    t.integer  "votable_id"
    t.string   "votable_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["votable_type", "votable_id"], name: "index_votes_on_votable_type_and_votable_id", using: :btree
    t.index ["voter_id"], name: "index_votes_on_voter_id", using: :btree
  end

end
