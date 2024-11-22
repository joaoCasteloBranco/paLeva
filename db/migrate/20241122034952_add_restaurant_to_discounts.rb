class AddRestaurantToDiscounts < ActiveRecord::Migration[7.2]
  def change
    add_reference :discounts, :restaurant, null: false, foreign_key: true
  end
end
