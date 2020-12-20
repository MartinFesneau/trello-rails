class Task < ApplicationRecord
  validates :name, presence: true
  belongs_to :user

  def self.change_position(task, position, user_id)
    # update position of the card to persist the order in each list
    task.position = position
    task.save
    persist_position(task, user_id)
  end

  def self.persist_position(task, user_id)
    status = task.status
    if status == "todo"
      todo_list = Task.where(status: status, user_id: user_id).order(position: :asc)
      change_position(todo_list, task)
      update_array(todo_list)
      
    elsif status == "inprogress"
      inprogress_list = Task.where(status: status, user_id: user_id).order(position: :asc)
      change_position(inprogress_list, task)
      update_array(inprogress_list)

    elsif status == "done"
      done_list = Task.where(status: status, user_id: user_id).order(position: :asc)
      change_position(done_list, task)
      update_array(done_list)
    end
  end

  def change_position(list, task)
    list.each do |element|
      if element.position > task.position
        element.position = element.position + 1
        element.save
      end
    end
  end

  def self.update_array(list)
    list.each_with_index do |element, index|
      element.position = index
      element.save
    end
  end
end
