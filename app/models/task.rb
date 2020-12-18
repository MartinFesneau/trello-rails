class Task < ApplicationRecord
  validates :name, presence: true

  def change_position(task, position)
    task.position = position
    task.save
  end

  def enleve_les_trous
  end
end
