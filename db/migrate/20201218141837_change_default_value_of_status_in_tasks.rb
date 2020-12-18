class ChangeDefaultValueOfStatusInTasks < ActiveRecord::Migration[6.0]
  def change
    change_column :tasks, :status, :string, default: "todo"
  end
end
