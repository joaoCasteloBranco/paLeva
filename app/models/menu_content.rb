class MenuContent < ApplicationRecord
  belongs_to :menu
  belongs_to :menu_item

  validates :menu_id, uniqueness: { scope: :menu_item_id, message: "Este item já está no cardápio." }
end
