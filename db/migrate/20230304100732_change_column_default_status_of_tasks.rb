class ChangeColumnDefaultStatusOfTasks < ActiveRecord::Migration[6.1]
  def change
    change_column_default :tasks, :status, from: "選択して下さい", to: 0
  end
end
