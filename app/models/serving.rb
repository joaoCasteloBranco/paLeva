class Serving < ApplicationRecord
  belongs_to :menu_item
  has_many :price_histories, dependent: :destroy

  after_create :record_price_history
  before_update :record_price_history
  

  def price_display
    BigDecimal(self.price.to_s) / 100
  end

  private 

  def record_price_history
    price_histories.create(price: self.price, changed_at: Time.current)
  end

end
