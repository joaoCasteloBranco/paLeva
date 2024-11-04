class PriceHistory < ApplicationRecord
  belongs_to :serving

  def price_display
    BigDecimal(self.price.to_s) / 100
  end
end
