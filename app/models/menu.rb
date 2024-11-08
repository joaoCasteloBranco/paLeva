class Menu < ApplicationRecord
  belongs_to :restaurant
  has_many :menu_contents
  has_many :menu_items, through: :menu_contents

  validates :name, uniqueness: { scope: :restaurant_id, message: "Já existe um cardápio com esse nome" }
  validates :name, presence: true
end
