class AddColumnStatusToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :status, :string, null: false, default: "選択して下さい"
  end
end
