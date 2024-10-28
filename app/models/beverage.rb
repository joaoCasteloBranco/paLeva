class Beverage < ApplicationRecord
  belongs_to :restaurant

  validates :name, :alcoholic, :restaurant, :description, presence: true
end
