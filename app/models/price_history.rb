class PriceHistory < ApplicationRecord
  belongs_to :serving

  validates :price, presence: true
  validates :price, comparison: {greater_than_or_equal_to: 0}

  def price_display
    BigDecimal(self.price.to_s) / 100
  end
end
