ActiveRecord::Schema.define(version: 2023_03_01_091230) do

  enable_extension "plpgsql"

  create_table "tasks", force: :cascade do |t|
    t.string "task_name", null: false
    t.text "detail", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
