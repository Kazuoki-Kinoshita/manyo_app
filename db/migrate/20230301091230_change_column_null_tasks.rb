class ChangeColumnNullTasks < ActiveRecord::Migration[6.1]
  def change
    change_column :tasks, :task_name, :string, null: false
    change_column :tasks, :detail, :text, null: false
  end
end
