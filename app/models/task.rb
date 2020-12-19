class Task < ApplicationRecord
  validates :name, presence: true
  belongs_to :user

  def enleve_les_trous
  end
end
