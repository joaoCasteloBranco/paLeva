class Menu < ApplicationRecord
  belongs_to :restaurant

  validates :name, uniqueness: { scope: :restaurant_id, message: "Já existe um cardápio com esse nome" }
  validates :name, presence: true
end
