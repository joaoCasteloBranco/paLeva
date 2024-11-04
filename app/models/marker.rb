class Marker < ApplicationRecord
  belongs_to :restaurant
  has_many :menu_item_markers
  has_many :menu_item, through: :menu_item_markers
end
