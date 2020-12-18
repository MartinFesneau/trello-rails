class Task < ApplicationRecord
  validates :name, presence: true
  belongs_to :user

  def change_position(task, position)
    task.position = position
    task.save
  end

  def enleve_les_trous
  end
end
