class Dish < ApplicationRecord
  belongs_to :restaurant

  validates :name, :description, :restaurant, presence: true
end
