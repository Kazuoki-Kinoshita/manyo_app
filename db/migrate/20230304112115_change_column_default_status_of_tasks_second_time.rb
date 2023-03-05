class ChangeColumnDefaultStatusOfTasksSecondTime < ActiveRecord::Migration[6.1]
  def change
    change_column_default :tasks, :status, from: 0, to: "選択して下さい"
  end
end
