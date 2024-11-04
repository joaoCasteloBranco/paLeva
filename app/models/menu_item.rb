class MenuItem < ApplicationRecord
  belongs_to :restaurant
  has_many :servings

  validates :name, :description, :restaurant, :status, presence: true
  enum :status, {:inactive=>0, :active=>1}

  validates :alcoholic, inclusion: { in: [true, false] }, if: :beverage?

  def beverage?
    type == "Beverage"
  end
end
