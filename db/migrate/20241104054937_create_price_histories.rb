class CreatePriceHistories < ActiveRecord::Migration[7.2]
  def change
    create_table :price_histories do |t|
      t.references :serving, null: false, foreign_key: true
      t.integer :price

      t.timestamps
    end
  end
end
