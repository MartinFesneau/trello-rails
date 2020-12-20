class Task < ApplicationRecord
  validates :name, presence: true
  belongs_to :user

  def self.persist_position(task, new_position)
    # update position of the card to persist the order in each list
    status = task.status
      # je prend toutes mes task de ma colonne tod
    puts "debut"
    puts task.position
    puts "new position"
    puts new_position
    task_arr = task.user.tasks.where(status: status).order(position: :asc)
    task_arr.each do |element|
      # si la position est >= à la nouvelle position de ma carte je lui met +1
      if element.position >= new_position
        element.position = element.position + 1
        element.save
      end
    end
    # je met ma tache à la nouvelle position
    task.position = new_position
    task.save
    puts "après changement"
    puts task.position
    # j'update toutes les positions de l'array
    update_array(task)
  end

  def self.update_array(task)
    list_to_update = task.user.tasks.where(status: task.status).order(position: :asc)
    list_to_update.each_with_index do |element, index|
      element.position = index
      element.save
    end
    puts "after update"
    puts task.position
  end
end
