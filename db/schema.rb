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

ActiveRecord::Schema.define(:version => 20121115125535) do

  create_table "albums", :id => false, :force => true do |t|
    t.string  "eartist_id"
    t.string  "title"
    t.integer "year"
  end

  add_index "albums", ["eartist_id"], :name => "index_albums_on_eartist_id"
  add_index "albums", ["title"], :name => "index_albums_on_title"

  create_table "artist_rates", :force => true do |t|
    t.integer "user_id"
    t.integer "tag_id"
    t.integer "artist_id"
    t.float   "score"
  end

  add_index "artist_rates", ["user_id", "tag_id"], :name => "index_artist_rates_on_user_id_and_tag_id"

  create_table "artist_tags", :force => true do |t|
    t.integer "user_id"
    t.string  "title"
  end

  add_index "artist_tags", ["user_id"], :name => "index_artist_tags_on_user_id"

  create_table "artists", :force => true do |t|
    t.string "eartist_id"
    t.string "artist_name"
  end

  add_index "artists", ["artist_name"], :name => "index_artists_on_artist_name"

  create_table "song_rates", :force => true do |t|
    t.integer "user_id"
    t.integer "tag_id"
    t.integer "song_id"
    t.float   "score"
  end

  add_index "song_rates", ["user_id", "tag_id"], :name => "index_song_rates_on_user_id_and_tag_id"

  create_table "songs", :force => true do |t|
    t.string  "track_id"
    t.string  "title"
    t.string  "song_id"
    t.string  "release"
    t.string  "artist_id"
    t.string  "artist_mbid"
    t.string  "artist_name"
    t.float   "duration"
    t.float   "artist_familiarity"
    t.float   "artist_hotttnesss"
    t.integer "year"
  end

  add_index "songs", ["artist_id"], :name => "index_songs_on_artist_id"
  add_index "songs", ["song_id"], :name => "index_songs_on_song_id", :unique => true

  create_table "tags", :force => true do |t|
    t.integer "user_id"
    t.string  "title"
  end

  add_index "tags", ["user_id"], :name => "index_tags_on_user_id"

  create_table "terms", :id => false, :force => true do |t|
    t.string "eartist_id"
    t.string "tag"
  end

  add_index "terms", ["eartist_id"], :name => "index_terms_on_eartist_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
