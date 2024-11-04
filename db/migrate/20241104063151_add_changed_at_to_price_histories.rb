class AddChangedAtToPriceHistories < ActiveRecord::Migration[7.2]
  def change
    add_column :price_histories, :changed_at, :datetime
  end
end
