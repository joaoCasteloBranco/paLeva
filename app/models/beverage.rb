class Beverage < ApplicationRecord
  belongs_to :restaurant

  validates :name, :restaurant, :description, :status, presence: true
  validates :alcoholic, inclusion: { in: [true, false] }

  enum :status, {:inactive=>0, :active=>1}
end
