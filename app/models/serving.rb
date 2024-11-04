class Serving < ApplicationRecord
  belongs_to :menu_item

  def price_display
    BigDecimal(self.price.to_s) / 100
  end

end
