class Serving < ApplicationRecord
  belongs_to :menu_item
  has_many :price_histories, dependent: :destroy
  has_many :order_items

  has_many :discount_servings
  has_many :discounts, through: :discount_servings

  validates :description, :price, :menu_item_id, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

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
