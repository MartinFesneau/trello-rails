class Task < ApplicationRecord
  validates :name, presence: true
  belongs_to :user

  def self.change_position(task, position, user_id)
    # update position of the card to persist the order in each list
    task.position = position
    task.save
    update_array_position(task, user_id)
  end

  def self.update_array_position(task, user_id)
    status = task.status
    if status == "todo"
      todo_list = Task.where(status: "todo", user_id: user_id)
      todo_list.each do |element|
        element.position = todo_list[todo_list.index(task) + 1].position
        element.save
      end
      todo_list.last.position = todo_list.length + 1
    elsif status == 'inprogress'

    elsif status == 'done'

    end
  end
end
