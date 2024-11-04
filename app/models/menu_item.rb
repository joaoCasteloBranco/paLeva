class MenuItem < ApplicationRecord
  belongs_to :restaurant
  has_many :servings
  has_many :menu_item_markers
  has_many :markers, through: :menu_item_markers

  validates :name, :description, :restaurant, :status, presence: true
  enum :status, {:inactive=>0, :active=>1}

  validates :alcoholic, inclusion: { in: [true, false] }, if: :beverage?

  def beverage?
    type == "Beverage"
  end
end
