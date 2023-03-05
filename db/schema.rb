ActiveRecord::Schema.define(version: 2023_03_05_023819) do

  enable_extension "plpgsql"

  create_table "tasks", force: :cascade do |t|
    t.string "title", null: false
    t.text "content", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "expired_at", default: -> { "CURRENT_DATE" }, null: false
    t.integer "status", null: false
    t.integer "priority", null: false
  end

end
