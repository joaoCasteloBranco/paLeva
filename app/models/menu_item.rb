class MenuItem < ApplicationRecord
  belongs_to :restaurant

  has_many :servings

  has_many :menu_item_markers
  has_many :markers, through: :menu_item_markers

  has_many :menu_contents
  has_many :menus, through: :menu_contents

  has_one_attached :photo

  validates :name, :description, :restaurant, :status, presence: true
  enum :status, {:inactive=>0, :active=>1}

  scope :active, -> {where(status: 1)}
  scope :inactive, -> {where(status: 0)}

  validates :alcoholic, inclusion: { in: [true, false] }, if: :beverage?

  def beverage?
    type == "Beverage"
  end
end
