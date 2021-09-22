# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_210_922_164_534) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'fuzzystrmatch'
  enable_extension 'pg_trgm'
  enable_extension 'plpgsql'

  create_table 'categories', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'favorites', force: :cascade do |t|
    t.string 'favoritable_type'
    t.bigint 'favoritable_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[favoritable_type favoritable_id], name: 'index_favorites_on_favoritable_type_and_favoritable_id'
  end

  create_table 'movies', force: :cascade do |t|
    t.boolean 'highlighted', default: false
    t.string 'title'
    t.text 'description'
    t.string 'thumbnail_key'
    t.string 'video_key'
    t.integer 'episode_number'
    t.string 'featured_thumbnail_key'
    t.bigint 'serie_id'
    t.bigint 'category_id'
    t.string 'thumbail_cover_key'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['category_id'], name: 'index_movies_on_category_id'
    t.index ['serie_id'], name: 'index_movies_on_serie_id'
  end

  create_table 'people', force: :cascade do |t|
    t.string 'name'
    t.string 'email'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'pg_search_documents', force: :cascade do |t|
    t.text 'content'
    t.string 'searchable_type'
    t.bigint 'searchable_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[searchable_type searchable_id], name: 'index_pg_search_documents_on_searchable_type_and_searchable_id'
  end

  create_table 'players', force: :cascade do |t|
    t.datetime 'start_date'
    t.datetime 'end_date'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'reviews', force: :cascade do |t|
    t.integer 'rating'
    t.text 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'series', force: :cascade do |t|
    t.boolean 'highlighted', default: false
    t.string 'title'
    t.text 'description'
    t.string 'thumbnail_key'
    t.bigint 'category_id'
    t.string 'featured_thumbmail_key'
    t.string 'thumbail_cover_key'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'last_watched_episode_id'
    t.index ['category_id'], name: 'index_series_on_category_id'
    t.index ['last_watched_episode_id'], name: 'index_series_on_last_watched_episode_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name'
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'movies', 'categories'
  add_foreign_key 'movies', 'series', column: 'serie_id'
  add_foreign_key 'series', 'categories'
  add_foreign_key 'series', 'movies', column: 'last_watched_episode_id'
end
