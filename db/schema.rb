# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_10_23_211433) do

  create_table "games", force: :cascade do |t|
    t.integer "user_id"
    t.integer "secret_word_id"
    t.integer "incorrect_guesses"
    t.boolean "win?"
    t.float "score"
    t.index ["secret_word_id"], name: "index_games_on_secret_word_id"
    t.index ["user_id"], name: "index_games_on_user_id"
  end

  create_table "high_scores", force: :cascade do |t|
    t.integer "user_id"
    t.integer "game_id"
    t.string "initials"
    t.index ["game_id"], name: "index_high_scores_on_game_id"
    t.index ["user_id"], name: "index_high_scores_on_user_id"
  end

  create_table "secret_words", force: :cascade do |t|
    t.string "word"
    t.string "hint"
    t.integer "difficulty"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
  end

  add_foreign_key "games", "secret_words"
  add_foreign_key "games", "users"
  add_foreign_key "high_scores", "games"
  add_foreign_key "high_scores", "users"
end
