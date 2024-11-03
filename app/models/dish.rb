class Dish < ApplicationRecord
  belongs_to :restaurant

  validates :name, :description, :restaurant, :status, presence: true

  enum :status, {:inactive=>0, :active=>1}
end
